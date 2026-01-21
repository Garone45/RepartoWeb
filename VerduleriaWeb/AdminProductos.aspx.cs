// IMPORTANTE: Llamamos a nuestras capas
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
        // ⚠️ PEGAR ACÁ TU STRING DE CONEXIÓN
        // (El mismo que usaste en la ventanita de conexión de Visual Studio)
        string connectionString = "Data Source=sql8006.site4now.net;Initial Catalog=db_ac4207_reparto;User Id=db_ac4207_reparto_admin;Password=yoeracampeon23";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Solo cargamos las listas la primera vez que entra a la página
                CargarCategorias();
                CargarGrilla();
            }
        }

        // =============================================================
        // 1. CARGAR EL COMBO DE CATEGORÍAS (Para que elijan "Frutas", etc.)
        // =============================================================
        void CargarCategorias()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                // Pedimos ID y Nombre para llenar el desplegable
                string query = "SELECT Id, Nombre FROM Categorias ORDER BY Nombre";
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // Configuramos el DropDownList
                ddlCategoria.DataSource = dt;
                ddlCategoria.DataValueField = "Id";     // Lo que se guarda (el número 1, 2, 3...)
                ddlCategoria.DataTextField = "Nombre";  // Lo que ve el usuario (Frutas, Verduras...)
                ddlCategoria.DataBind();

                // Agregamos una opción por defecto arriba de todo
                ddlCategoria.Items.Insert(0, new ListItem("-- Seleccioná --", "0"));
            }
        }

        // =============================================================
        // 2. CARGAR LA GRILLA DE PRODUCTOS
        // =============================================================
        void CargarGrilla()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                // ACÁ ESTÁ EL TRUCO: Usamos INNER JOIN para traer el nombre de la categoría
                string query = @"
                    SELECT P.Nombre, P.Precio, P.Unidad, P.Activo, C.Nombre as CategoriaNombre 
                    FROM Productos P
                    INNER JOIN Categorias C ON P.IdCategoria = C.Id
                    ORDER BY P.Id DESC";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                dgvProductos.DataSource = dt;
                dgvProductos.DataBind();
            }
        }

        // =============================================================
        // 3. GUARDAR EL PRODUCTO NUEVO
        // =============================================================
        protected void dgvProductos_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Buscamos el ID del renglón que tocaste
            int id = Convert.ToInt32(dgvProductos.SelectedDataKey.Value);

            // Lo guardamos en el campo oculto para acordarnos después
            hfIdProducto.Value = id.ToString();

            // Vamos a buscar los datos de ese producto específico a la base
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Productos WHERE Id = @Id";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Id", id);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    // LLENAMOS LOS CAMPOS DE ARRIBA CON LOS DATOS DE LA BASE
                    txtNombre.Text = reader["Nombre"].ToString();
                    txtPrecio.Text = reader["Precio"].ToString();
                    txtUnidad.Text = reader["Unidad"].ToString();
                    txtDescripcion.Text = reader["Descripcion"].ToString();

                    // Seleccionamos la categoría correcta en el combo
                    ddlCategoria.SelectedValue = reader["IdCategoria"].ToString();
                }
                con.Close();
            }

            // Cambiamos el texto del botón para que se entienda
            btnGuardar.Text = "🔄 Actualizar Producto";
            btnCancelar.Visible = true; // Mostramos el botón cancelar
        }

        // =============================================================
        // 2. GUARDAR (INTELIGENTE: CREA O EDITA)
        // =============================================================
        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "";

                // ¿ES NUEVO O ES EDICIÓN?
                if (hfIdProducto.Value == "")
                {
                    // NO hay ID guardado -> ES NUEVO (INSERT)
                    query = @"INSERT INTO Productos (Nombre, IdCategoria, Precio, Unidad, Descripcion, Activo) 
                          VALUES (@Nombre, @IdCategoria, @Precio, @Unidad, @Descripcion, 1)";
                }
                else
                {
                    // SÍ hay ID -> ES EDICIÓN (UPDATE)
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

                // Si es UPDATE, agregamos el parámetro ID
                if (hfIdProducto.Value != "")
                {
                    cmd.Parameters.AddWithValue("@Id", hfIdProducto.Value);
                }

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }

            LimpiarFormulario();
            CargarGrilla(); // Actualizamos la lista para ver los cambios
            lblMensaje.Text = "¡Guardado correctamente! ✅";
        }

        
        protected void dgvProductos_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            // Obtenemos el ID desde la grilla
            int id = Convert.ToInt32(dgvProductos.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                // Opción A: Borrado Físico (Desaparece para siempre)
                string query = "DELETE FROM Productos WHERE Id = @Id";

                // Opción B: Borrado Lógico (Solo lo ocultamos, cambiar DELETE por UPDATE Activo=0)
                // string query = "UPDATE Productos SET Activo = 0 WHERE Id = @Id";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Id", id);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }

            CargarGrilla();
            lblMensaje.Text = "Producto eliminado 🗑️";
        }

        // =============================================================
        // 4. LIMPIAR Y CANCELAR
        // =============================================================
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

            // RESETEAMOS EL MODO EDICIÓN
            hfIdProducto.Value = ""; // Borramos el ID de la memoria
            btnGuardar.Text = "Guardar Producto"; // Vuelve a decir Guardar
            btnCancelar.Visible = false; // Ocultamos el cancelar
        }

    }
}