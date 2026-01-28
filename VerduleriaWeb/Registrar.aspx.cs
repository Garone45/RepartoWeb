using System;
using Dominio;
using Negocio;

namespace VerduleriaWeb
{
    public partial class Registro : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            try
            {
                // 1. Cargamos los datos del formulario al objeto
                Usuario user = new Usuario();
                user.Email = txtEmail.Text;
                user.Pass = txtPass.Text;
                user.Nombre = txtNombre.Text;
                user.Apellido = txtApellido.Text;
                user.Telefono = txtTelefono.Text;
                user.Direccion = txtDireccion.Text;
                user.TipoUsuario = 2; // Cliente normal

                // 2. Guardamos en Base de Datos
                UsuarioNegocio negocio = new UsuarioNegocio();
                negocio.Registrar(user);

                // 3. ¡Auto-Login! 
                // Como ya se registró, lo guardamos en sesión directamente
                // para que no tenga que ir al login a poner los datos de nuevo.

                // IMPORTANTE: Necesitamos el ID que le puso la base de datos.
                // Como "Registrar" no devuelve el ID (todavía), hacemos un truquito:
                // Lo mandamos al Login, o podemos hacer un "Loguear" interno acá.

                // Opción simple: Guardamos en sesión y vamos al catálogo.
                // (Ojo: user.Id va a ser 0 acá, pero para comprar sirve igual por ahora)
                Session.Add("usuario", user);

                Response.Redirect("Catalogo.aspx", false);
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al registrarse. Quizás el email ya existe.";
                lblMensaje.Visible = true;
            }
        }
    }
}