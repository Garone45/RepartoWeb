using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VerduleriaWeb
{
    public partial class Checkout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [System.Web.Services.WebMethod] // <-- ESTO ES CLAVE PARA QUE FUNCIONE PageMethods
        public static bool GuardarPedido(string nombre, string zona, string direccion, string telefono, string fechaEntrega, decimal total)
        {
            try
            {
                // Juntamos la zona con la dirección para que en la base de datos quede prolijo
                string direccionCompleta = zona + " - " + direccion;
                string comentarioFecha = "Entregar el día: " + fechaEntrega;

                // Asegurate de poner tu cadena de conexión real acá
                using (SqlConnection conexion = new SqlConnection("tu_cadena_conexion"))
                {
                    // Guardamos la direccionCompleta en Direccion y la fechaEntrega en Comentarios
                    string query = "INSERT INTO Pedidos (Cliente, Direccion, Telefono, Comentarios, Total, Fecha) " +
                                   "VALUES (@nombre, @direccion, @telefono, @comentarios, @total, GETDATE())";

                    SqlCommand cmd = new SqlCommand(query, conexion);
                    cmd.Parameters.AddWithValue("@nombre", nombre);
                    cmd.Parameters.AddWithValue("@direccion", direccionCompleta);
                    cmd.Parameters.AddWithValue("@telefono", telefono);
                    cmd.Parameters.AddWithValue("@comentarios", comentarioFecha);
                    cmd.Parameters.AddWithValue("@total", total);

                    conexion.Open();
                    cmd.ExecuteNonQuery();
                    return true;
                }
            }
            catch
            {
                return false;
            }
        }

        public static int ProcesarPedido(string nombre, string direccion, string telefono, decimal total, List<CarritoItem> productos)
        {
            using (SqlConnection con = new SqlConnection("tu_cadena_de_conexion"))
            {
                con.Open();
                SqlTransaction tra = con.BeginTransaction();

                try
                {
                    // 1. Verificamos o creamos el Usuario (Invitado)
                    // Buscamos si el teléfono ya existe para no duplicar clientes de Victoria
                    string sqlUser = "IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE Telefono = @tel) " +
                                    "INSERT INTO Usuarios (Nombre, Telefono, Direccion, EsInvitado) VALUES (@nom, @tel, @dir, 1); " +
                                    "SELECT IdUsuario FROM Usuarios WHERE Telefono = @tel;";

                    SqlCommand cmdUser = new SqlCommand(sqlUser, con, tra);
                    cmdUser.Parameters.AddWithValue("@nom", nombre);
                    cmdUser.Parameters.AddWithValue("@tel", telefono);
                    cmdUser.Parameters.AddWithValue("@dir", direccion);
                    int idUsuario = (int)cmdUser.ExecuteScalar();

                    // 2. Creamos el Pedido
                    string sqlPedido = "INSERT INTO Pedidos (IdUsuario, Fecha, Total, Estado) " +
                                       "VALUES (@idU, GETDATE(), @total, 'Pendiente'); SELECT SCOPE_IDENTITY();";

                    SqlCommand cmdPed = new SqlCommand(sqlPedido, con, tra);
                    cmdPed.Parameters.AddWithValue("@idU", idUsuario);
                    cmdPed.Parameters.AddWithValue("@total", total);
                    int idPedido = Convert.ToInt32(cmdPed.ExecuteScalar());

                    // 3. Guardamos cada producto en DetallesPedido
                    foreach (var item in productos)
                    {
                        string sqlDetalle = "INSERT INTO DetallesPedido (IdPedido, IdProducto, Cantidad, PrecioUnitario) " +
                                           "VALUES (@idP, @idProd, @cant, @precio)";
                        SqlCommand cmdDet = new SqlCommand(sqlDetalle, con, tra);
                        cmdDet.Parameters.AddWithValue("@idP", idPedido);
                        cmdDet.Parameters.AddWithValue("@idProd", item.IdProducto);
                        cmdDet.Parameters.AddWithValue("@cant", item.Cantidad);
                        cmdDet.Parameters.AddWithValue("@precio", item.Precio);
                        cmdDet.ExecuteNonQuery();
                    }

                    tra.Commit(); // Si llegamos acá, se guarda todo perfecto
                    return idPedido;
                }
                catch (Exception)
                {
                    tra.Rollback(); // Si algo falló, deshace los cambios para no romper la DB
                    return 0;
                }
            }
        }
        public class CarritoItem
        {
            public int IdProducto { get; set; }
            public int Cantidad { get; set; }
            public decimal Precio { get; set; }
        }

    }

}