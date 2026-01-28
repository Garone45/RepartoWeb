using Negocio;
using System;
using System.Collections.Generic;
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
            if (!IsPostBack)
            {
                
                ProductoNegocio negocio = new ProductoNegocio();

                
                repProductos.DataSource = negocio.Listar();
                repProductos.DataBind();
            }
        }
        protected void btnSalir_Click(object sender, EventArgs e)
        {
            // 1. Borramos al usuario de la memoria
            Session.Remove("usuario");

            // 2. Lo mandamos al Login (o recargamos el catálogo como invitado)
            Response.Redirect("Login.aspx");
        }
        protected void btnFinalizar_Click(object sender, EventArgs e)
        {
            // 1. RECUPERAMOS LOS DATOS DE LOS HIDDEN FIELDS
            string jsonCarrito = hfCarritoJson.Value;
            string nombre = hfNombre.Value;
            string direccion = hfDireccion.Value;
            string aclaraciones = hfAclaraciones.Value;

            // 2. CONVERTIMOS EL JSON A LISTA C#
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            List<ItemCarrito> listaProductos = serializer.Deserialize<List<ItemCarrito>>(jsonCarrito);

            int idPedidoGenerado = 0;
            decimal totalPedido = 0;

            // Calculamos total
            foreach (var item in listaProductos) totalPedido += item.precio;

            // --- NUEVO: RECUPERAMOS AL USUARIO DE LA SESIÓN ---
            // Esto sirve para saber si es un usuario registrado o un invitado
            Dominio.Usuario usuarioLogueado = (Dominio.Usuario)Session["usuario"];
            object idUsuarioParaGuardar = DBNull.Value; // Por defecto asumimos que es NULL (Invitado)

            if (usuarioLogueado != null)
            {
                idUsuarioParaGuardar = usuarioLogueado.Id; // Si está logueado, usamos su ID real
            }
            // --------------------------------------------------

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                // 3. GUARDAMOS LA CABECERA DEL PEDIDO (Ahora con IdUsuario)
                string queryPedido = @"INSERT INTO Pedidos (Fecha, Cliente, Direccion, Comentarios, Total, IdUsuario) 
                               VALUES (GETDATE(), @Cli, @Dir, @Com, @Tot, @IdUsu);
                               SELECT SCOPE_IDENTITY();";

                SqlCommand cmd = new SqlCommand(queryPedido, con);
                cmd.Parameters.AddWithValue("@Cli", nombre);
                cmd.Parameters.AddWithValue("@Dir", direccion);
                cmd.Parameters.AddWithValue("@Com", aclaraciones);
                cmd.Parameters.AddWithValue("@Tot", totalPedido);

                // Pasamos el ID del usuario (o NULL si no está logueado)
                cmd.Parameters.AddWithValue("@IdUsu", idUsuarioParaGuardar);

                // Ejecutamos y guardamos el ID nuevo
                idPedidoGenerado = Convert.ToInt32(cmd.ExecuteScalar());

                // 4. GUARDAMOS CADA PRODUCTO EN "DetallesPedido"
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

                // Redireccionamos SOLO a Mercado Pago
                // (El código se detiene acá, por eso lo de WhatsApp de abajo no se ejecutaría nunca)
                Response.Redirect(linkPago, false);
                Context.ApplicationInstance.CompleteRequest();
            }
        }

        public class ItemCarrito
        {
            public string nombre { get; set; }
            public int precio { get; set; }
        }
    }
}