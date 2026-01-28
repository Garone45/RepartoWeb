using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using Negocio;

namespace VerduleriaWeb
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Si ya entró, lo echamos al catálogo
            if (Session["usuario"] != null)
            {
                Response.Redirect("Catalogo.aspx", false);
            }
        }

        protected void btnIngresar_Click(object sender, EventArgs e)
        {
            Usuario usuario = new Usuario();
            UsuarioNegocio negocio = new UsuarioNegocio();

            try
            {
                // 1. Validamos que escriba algo
                if (string.IsNullOrEmpty(txtEmail.Text) || string.IsNullOrEmpty(txtPass.Text))
                {
                    lblError.Text = "Completá todos los campos por favor.";
                    lblError.Visible = true;
                    return;
                }

                usuario.Email = txtEmail.Text;
                usuario.Pass = txtPass.Text;

                // 2. Probamos loguear contra Site4Now
                if (negocio.Loguear(usuario))
                {
                    // ¡EXITO! Guardamos al usuario en la mochila (Sesión)
                    Session.Add("usuario", usuario);

                    // Nos vamos a comprar
                    Response.Redirect("Catalogo.aspx", false);
                }
                else
                {
                    lblError.Text = "Email o contraseña incorrectos.";
                    lblError.Visible = true;
                }
            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
                // Response.Redirect("Error.aspx"); // Si tuvieras página de error
                // Cuando hay error:
                pnlError.Visible = true;
                lblError.Text = "Usuario o clave incorrectos";
            }
        }
    }
}