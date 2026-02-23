using System;
using System.Collections.Generic;
using Dominio;
using Negocio;

namespace VerduleriaWeb
{
    public partial class Inicio : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // 1. Traemos TODOS los productos activos de la base de datos
                ProductoNegocio negocio = new ProductoNegocio();
                List<Producto> listaCompleta = negocio.Listar();

                // 2. Filtramos con una sola línea para quedarnos SOLAMENTE con los Combos 
                // (Asumimos que "Combos y Ofertas" es la Categoría con Id = 1, como en tu SQL)
                List<Producto> listaCombos = listaCompleta.FindAll(x => x.Categoria.Id == 1);

                // 3. Se los pasamos a la pantalla
                repCombos.DataSource = listaCombos;
                repCombos.DataBind();
            }
        }
    }
}