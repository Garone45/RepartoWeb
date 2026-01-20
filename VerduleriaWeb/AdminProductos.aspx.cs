using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
// IMPORTANTE: Llamamos a nuestras capas
using Dominio;
using Negocio;

namespace VerduleriaWeb
{
    public partial class AdminProductos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // El !IsPostBack es CRÍTICO. 
            // Significa: "Solo hacé esto la primera vez que entras a la página".
            // Si no lo ponés, cuando toques "Guardar", se te resetea el DropDownList y falla.
            if (!IsPostBack)
            {
                CargarCategorias();
                CargarGrilla();
            }
        }

        private void CargarCategorias()
        {
            CategoriaNegocio negocio = new CategoriaNegocio();
            List<Categoria> lista = negocio.Listar();

            ddlCategoria.DataSource = lista;
            // Configuración del DropDown:
            ddlCategoria.DataValueField = "Id";      // Lo que guardamos en BD (el número)
            ddlCategoria.DataTextField = "Nombre";   // Lo que ve el usuario (el texto)
            ddlCategoria.DataBind();
        }

        private void CargarGrilla()
        {
            ProductoNegocio negocio = new ProductoNegocio();
            dgvProductos.DataSource = negocio.Listar();
            dgvProductos.DataBind();
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                // 1. Instanciamos el objeto Dominio y lo llenamos con los datos del formulario
                Producto nuevo = new Producto();

                nuevo.Nombre = txtNombre.Text;
                nuevo.Precio = int.Parse(txtPrecio.Text); // Ojo acá, si ponés letras explota (después validamos)
                nuevo.Unidad = txtUnidad.Text;
                nuevo.Descripcion = txtDescripcion.Text;

                // Mapeamos la Categoría seleccionada
                nuevo.Categoria.Id = int.Parse(ddlCategoria.SelectedValue);

                // 2. Llamamos a la capa de Negocio
                ProductoNegocio negocio = new ProductoNegocio();
                negocio.Agregar(nuevo);

                // 3. Avisamos y refrescamos
                lblMensaje.Text = "¡Guardado con éxito!";
                lblMensaje.ForeColor = System.Drawing.Color.Green;

                // Limpiamos las cajas
                txtNombre.Text = "";
                txtPrecio.Text = "";
                txtUnidad.Text = "";
                txtDescripcion.Text = "";

                // IMPORTANTE: Recargamos la grilla para ver el nuevo producto
                CargarGrilla();
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error: " + ex.Message;
                lblMensaje.ForeColor = System.Drawing.Color.Red;
            }
        }
    }
}