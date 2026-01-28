using System;
using System.Collections.Generic;
using System.Linq; // Necesario para .Sum()
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using Negocio;

namespace VerduleriaWeb
{
    public partial class MisPedidos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["usuario"] == null)
                {
                    Response.Redirect("Login.aspx");
                    return;
                }
                CargarPedidos();
            }
        }

        void CargarPedidos()
        {
            Usuario usuario = (Usuario)Session["usuario"];
            PedidoNegocio negocio = new PedidoNegocio();

            // Cargamos la lista principal
            dgvPedidos.DataSource = negocio.ListarPorUsuario(usuario.Id);
            dgvPedidos.DataBind();
        }

        // Evento cuando tocan el botón "Ver Productos"
        protected void dgvPedidos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "VerDetalle")
            {
                // 1. Averiguamos qué ID de pedido tocaron
                int idPedido = Convert.ToInt32(e.CommandArgument);

                // 2. Buscamos los productos de ese pedido
                PedidoNegocio negocio = new PedidoNegocio();
                List<DetallePedido> detalles = negocio.ListarDetalle(idPedido);

                // 3. Llenamos el Modal
                lblIdPedidoModal.Text = idPedido.ToString();

                repDetalles.DataSource = detalles;
                repDetalles.DataBind();

                // Calculamos el total sumando (Cantidad * Precio)
                decimal total = detalles.Sum(x => x.Cantidad * x.PrecioUnitario);
                lblTotalModal.Text = total.ToString("0");

                // 4. Mostramos el Modal
                pnlModal.Visible = true;
                upModal.Update(); // Forzamos la actualización visual
            }
        }

        // Botón "X" para cerrar el modal
        protected void btnCerrar_Click(object sender, EventArgs e)
        {
            pnlModal.Visible = false;
            upModal.Update();
        }
    }
}