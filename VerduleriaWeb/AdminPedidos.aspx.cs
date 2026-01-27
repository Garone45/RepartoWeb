using System;
using System.Data;
using System.Data.SqlClient;

namespace VerduleriaWeb
{
    public partial class AdminPedidos : System.Web.UI.Page
    {
       
        string connectionString = "Data Source=sql8006.site4now.net;Initial Catalog=db_ac4207_reparto;User Id=db_ac4207_reparto_admin;Password=yoeracampeon23";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarPedidos();
            }
        }

        // 1. CARGA LA LISTA DE PEDIDOS (CABECERA)
        void CargarPedidos()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                // Traemos los últimos pedidos primero
                string query = "SELECT Id, Fecha, Cliente, Direccion, Total FROM Pedidos ORDER BY Fecha DESC";
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gridPedidos.DataSource = dt;
                gridPedidos.DataBind();
            }
        }

        // 2. CUANDO TOCÁS "VER DETALLE"
        protected void gridPedidos_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Obtenemos el ID del pedido seleccionado
            int idPedido = Convert.ToInt32(gridPedidos.SelectedDataKey.Value);

            // Ponemos el número en el título
            lblNroPedido.Text = idPedido.ToString();

            // Cargamos la segunda grilla
            CargarDetalles(idPedido);

            // Hacemos visible el panel azul de abajo
            panelDetalle.Visible = true;
        }


        void CargarDetalles(int idPedido)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                
                string query = @"
                    SELECT P.Nombre as Producto, D.PrecioUnitario, D.Cantidad, (D.PrecioUnitario * D.Cantidad) as Subtotal
                    FROM DetallesPedido D
                    INNER JOIN Productos P ON D.IdProducto = P.Id
                    WHERE D.IdPedido = @IdPedido";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@IdPedido", idPedido);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                DataTable dt = new DataTable();
                dt.Load(reader);
                con.Close();

                gridDetalles.DataSource = dt;
                gridDetalles.DataBind();

                // Calculamos el total visualmente
                decimal total = 0;
                foreach (DataRow row in dt.Rows)
                {
                    total += Convert.ToDecimal(row["Subtotal"]);
                }
                lblTotalDetalle.Text = total.ToString();
            }
        }
    }
}