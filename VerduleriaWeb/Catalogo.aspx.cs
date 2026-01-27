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
        protected void btnFinalizar_Click(object sender, EventArgs e)
        {
           
            string jsonCarrito = hfCarritoJson.Value;
            string nombre = hfNombre.Value;
            string direccion = hfDireccion.Value;
            string aclaraciones = hfAclaraciones.Value;

          
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            List<ItemCarrito> listaProductos = serializer.Deserialize<List<ItemCarrito>>(jsonCarrito);

            int idPedidoGenerado = 0;
            decimal totalPedido = 0;

            // Calculamos total
            foreach (var item in listaProductos) totalPedido += item.precio;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

             
                string queryPedido = @"INSERT INTO Pedidos (Fecha, Cliente, Direccion, Comentarios, Total) 
                                       VALUES (GETDATE(), @Cli, @Dir, @Com, @Tot);
                                       SELECT SCOPE_IDENTITY();";

                SqlCommand cmd = new SqlCommand(queryPedido, con);
                cmd.Parameters.AddWithValue("@Cli", nombre);
                cmd.Parameters.AddWithValue("@Dir", direccion);
                cmd.Parameters.AddWithValue("@Com", aclaraciones);
                cmd.Parameters.AddWithValue("@Tot", totalPedido);

                
                idPedidoGenerado = Convert.ToInt32(cmd.ExecuteScalar());

               
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

                MercadoPagoService mp = new MercadoPagoService();

                
                string linkPago = mp.CrearPreferencia(nombre, totalPedido, idPedidoGenerado);

                // 3. Redireccionamos a la web de pago
                Response.Redirect(linkPago);
                con.Close();
            }

      
            string telefonoNegocio = "5491138517333"; 

            string mensajeWsp = $"Hola! Soy *{nombre}*.%0A";
            mensajeWsp += $"Acabo de confirmar el *Pedido #{idPedidoGenerado}* en la web.%0A%0A";
            mensajeWsp += "Detalle:%0A";

            foreach (var item in listaProductos)
            {
                mensajeWsp += $"▪️ {item.nombre} (${item.precio})%0A";
            }

            mensajeWsp += $"%0A*TOTAL: ${totalPedido}*";
            mensajeWsp += $"%0A📍 Envío a: {direccion}";
            if (!string.IsNullOrEmpty(aclaraciones)) mensajeWsp += $"%0A📝 Nota: {aclaraciones}";

            // 6. REDIRECCIONAMOS A WHATSAPP
            Response.Redirect($"https://wa.me/{telefonoNegocio}?text={mensajeWsp}");
        }

   
        public class ItemCarrito
        {
            public string nombre { get; set; }
            public int precio { get; set; }
        }
    }
}