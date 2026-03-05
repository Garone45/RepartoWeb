using Negocio;
using System;
using System.Collections.Generic;
using System.Data; // Agregamos esto para el manejo de parámetros
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VerduleriaWeb
{
    public partial class Catalogo : System.Web.UI.Page
    {
        
        string connectionString = "Data Source=sql8006.site4now.net;Initial Catalog=db_ac4207_reparto;User Id=db_ac4207_reparto_admin;Password=yoeracampeon23";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuario"] != null)
            {
                // Si está logueado, le mostramos la puerta de Salir
                btnSalirMobile.Visible = true;
            }
            else
            {
                // Si no está logueado, la puerta no existe
                btnSalirMobile.Visible = false;
            }

            if (!IsPostBack)
            {
                try
                {
                    ProductoNegocio negocio = new ProductoNegocio();
                    repProductos.DataSource = negocio.Listar();
                    repProductos.DataBind();
                }
                catch (Exception ex)
                {
                    // Por si falla la base al cargar
                    Session.Add("Error", ex.ToString());
                }
            }
           
        }

        protected void btnSalir_Click(object sender, EventArgs e)
        {
            Session.Remove("usuario");
            Response.Redirect("Login.aspx");
        }

        protected void btnFinalizar_Click(object sender, EventArgs e)
        {
            try
            {
                // 1. RECUPERAMOS LOS DATOS
                string jsonCarrito = hfCarritoJson.Value;
                string nombre = hfNombre.Value;
                string direccion = hfDireccion.Value;
                string aclaraciones = hfAclaraciones.Value;

                if (string.IsNullOrEmpty(jsonCarrito) || jsonCarrito == "[]") return;

                JavaScriptSerializer serializer = new JavaScriptSerializer();
                List<ItemCarrito> listaProductos = serializer.Deserialize<List<ItemCarrito>>(jsonCarrito);

                decimal totalPedido = 0;
                foreach (var item in listaProductos) totalPedido += item.precio;

               
                Dominio.Usuario usuarioLogueado = (Dominio.Usuario)Session["usuario"];

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open();

                    // CABECERA DEL PEDIDO
                    string queryPedido = @"INSERT INTO Pedidos (Fecha, Cliente, Direccion, Comentarios, Total, IdUsuario) 
                                         VALUES (GETDATE(), @Cli, @Dir, @Com, @Tot, @IdUsu);
                                         SELECT SCOPE_IDENTITY();";

                    SqlCommand cmd = new SqlCommand(queryPedido, con);
                    cmd.Parameters.AddWithValue("@Cli", nombre);
                    cmd.Parameters.AddWithValue("@Dir", direccion);
                    cmd.Parameters.AddWithValue("@Com", aclaraciones);
                    cmd.Parameters.AddWithValue("@Tot", totalPedido);

                    // Manejo de NULL para el ID de Usuario
                    if (usuarioLogueado != null)
                        cmd.Parameters.AddWithValue("@IdUsu", usuarioLogueado.Id);
                    else
                        cmd.Parameters.AddWithValue("@IdUsu", DBNull.Value);

                    int idPedidoGenerado = Convert.ToInt32(cmd.ExecuteScalar());

                    // DETALLES DEL PEDIDO
                    foreach (var item in listaProductos)
                    {
                        string queryDetalle = @"INSERT INTO DetallesPedido (IdPedido, NombreProducto, PrecioUnitario, Cantidad) 
                                              VALUES (@IdPed, @Nom, @Prec, 1)";

                        SqlCommand cmdDet = new SqlCommand(queryDetalle, con);
                        cmdDet.Parameters.AddWithValue("@IdPed", idPedidoGenerado);
                        cmdDet.Parameters.AddWithValue("@Nom", item.nombre);
                        cmdDet.Parameters.AddWithValue("@Prec", item.precio);
                        cmdDet.ExecuteNonQuery();
                    }

                    // --- MERCADO PAGO ---
                    MercadoPagoService mp = new MercadoPagoService();
                    string linkPago = mp.CrearPreferencia(nombre, totalPedido, idPedidoGenerado);

                    // REDIRECCIÓN FINAL
                    Response.Redirect(linkPago, false);
                    Context.ApplicationInstance.CompleteRequest();
                }
            }
            catch (Exception ex)
            {
                // Si algo falla, lo mostramos para debuguear
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
            if (Session["usuario"] != null)
            {
                // Si hay alguien logueado, mostramos Salir y ocultamos Ingresar
                btnSalirMobile.Visible = true;
               
            }
            else
            {
                // Si es un invitado, mostramos Ingresar y ocultamos Salir
                btnSalirMobile.Visible = false;
               
            }
        }

        // CLASE DE APOYO (IMPORTANTE: El precio debe ser decimal)
        public class ItemCarrito
        {
            public string nombre { get; set; }
            public decimal precio { get; set; } // Cambiado de int a decimal
        }

    }

}