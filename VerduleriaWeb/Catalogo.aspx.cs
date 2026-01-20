using Negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VerduleriaWeb
{
    public partial class Catalogo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Reutilizamos la misma lógica que en el Admin
                ProductoNegocio negocio = new ProductoNegocio();

                // Le pasamos la lista al Repeater
                repProductos.DataSource = negocio.Listar();
                repProductos.DataBind();
            }
        }
    }
}