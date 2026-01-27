
using Dominio;
using Negocio;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VerduleriaWeb
{
    public partial class AdminProductos : System.Web.UI.Page
    {
       
        string connectionString = "Data Source=sql8006.site4now.net;Initial Catalog=db_ac4207_reparto;User Id=db_ac4207_reparto_admin;Password=yoeracampeon23";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
       
                CargarCategorias();
                CargarGrilla();
            }
        }

       
        void CargarCategorias()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
  
                string query = "SELECT Id, Nombre FROM Categorias ORDER BY Nombre";
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

          
                ddlCategoria.DataSource = dt;
                ddlCategoria.DataValueField = "Id";     
                ddlCategoria.DataTextField = "Nombre";  
                ddlCategoria.DataBind();

                // Agregamos una opción por defecto arriba de todo
                ddlCategoria.Items.Insert(0, new ListItem("-- Seleccioná --", "0"));
            }
        }


        void CargarGrilla()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {

                string query = @"
    SELECT P.Id, P.Nombre, P.Precio, P.Unidad, P.Activo, P.Descripcion, P.IdCategoria, C.Nombre as CategoriaNombre 
    FROM Productos P
    INNER JOIN Categorias C ON P.IdCategoria = C.Id
    WHERE P.Activo = 1
    ORDER BY P.Id DESC";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                dgvProductos.DataSource = dt;
                dgvProductos.DataBind();
            }
        }

        protected void dgvProductos_SelectedIndexChanged(object sender, EventArgs e)
        {
   
            int id = Convert.ToInt32(dgvProductos.SelectedDataKey.Value);

        
            hfIdProducto.Value = id.ToString();

      
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Productos WHERE Id = @Id";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Id", id);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
     
                    txtNombre.Text = reader["Nombre"].ToString();
                    txtPrecio.Text = reader["Precio"].ToString();
                    txtUnidad.Text = reader["Unidad"].ToString();
                    txtDescripcion.Text = reader["Descripcion"].ToString();

                    ddlCategoria.SelectedValue = reader["IdCategoria"].ToString();
                }
                con.Close();
            }

            btnGuardar.Text = "🔄 Actualizar Producto";
            btnCancelar.Visible = true; 
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "";

    
                if (hfIdProducto.Value == "")
                {
       
                    query = @"INSERT INTO Productos (Nombre, IdCategoria, Precio, Unidad, Descripcion, Activo) 
                          VALUES (@Nombre, @IdCategoria, @Precio, @Unidad, @Descripcion, 1)";
                }
                else
                {
  
                    query = @"UPDATE Productos SET 
                            Nombre = @Nombre, 
                            IdCategoria = @IdCategoria, 
                            Precio = @Precio, 
                            Unidad = @Unidad, 
                            Descripcion = @Descripcion 
                          WHERE Id = @Id";
                }

                SqlCommand cmd = new SqlCommand(query, con);

                // Pasamos los parámetros
                cmd.Parameters.AddWithValue("@Nombre", txtNombre.Text);
                cmd.Parameters.AddWithValue("@IdCategoria", ddlCategoria.SelectedValue);
                cmd.Parameters.AddWithValue("@Precio", int.Parse(txtPrecio.Text));
                cmd.Parameters.AddWithValue("@Unidad", txtUnidad.Text);
                cmd.Parameters.AddWithValue("@Descripcion", txtDescripcion.Text);

      
                if (hfIdProducto.Value != "")
                {
                    cmd.Parameters.AddWithValue("@Id", hfIdProducto.Value);
                }

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }

            LimpiarFormulario();
            CargarGrilla(); 
            lblMensaje.Text = "¡Guardado correctamente! ✅";
        }


        protected void dgvProductos_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

            int id = Convert.ToInt32(dgvProductos.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(connectionString))
            {
          
                string query = "UPDATE Productos SET Activo = 0 WHERE Id = @Id";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Id", id);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }

  
            CargarGrilla();
            lblMensaje.Text = "Producto eliminado correctamente 🗑️";
        }

    
        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            LimpiarFormulario();
        }

        void LimpiarFormulario()
        {
            txtNombre.Text = "";
            txtPrecio.Text = "";
            txtUnidad.Text = "";
            txtDescripcion.Text = "";
            ddlCategoria.SelectedIndex = 0;

   
            hfIdProducto.Value = ""; 
            btnGuardar.Text = "Guardar Producto"; 
            btnCancelar.Visible = false; 
        }

    }
}