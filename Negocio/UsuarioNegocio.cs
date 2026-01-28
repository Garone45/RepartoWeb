using System;
using Dominio;

namespace Negocio
{
    public class UsuarioNegocio
    {
        public bool Loguear(Usuario usuario)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                // Consultamos a la base de datos en la nube
                datos.SetearConsulta("SELECT Id, TipoUsuario, Nombre, Apellido, Direccion, Telefono FROM Usuarios WHERE Email = @user AND Pass = @pass");
                datos.SetearParametro("@user", usuario.Email);
                datos.SetearParametro("@pass", usuario.Pass);

                datos.EjecutarLectura();

                if (datos.Lector.Read())
                {
                    // ¡Encontramos al usuario! Llenamos sus datos
                    usuario.Id = (int)datos.Lector["Id"];
                    usuario.TipoUsuario = (int)datos.Lector["TipoUsuario"];

                    // Validamos nulos por si alguno no cargó el nombre
                    if (!(datos.Lector["Nombre"] is DBNull))
                        usuario.Nombre = (string)datos.Lector["Nombre"];

                    if (!(datos.Lector["Apellido"] is DBNull))
                        usuario.Apellido = (string)datos.Lector["Apellido"];

                    if (!(datos.Lector["Direccion"] is DBNull))
                        usuario.Direccion = (string)datos.Lector["Direccion"];

                    return true; // Login exitoso
                }
                return false; // Usuario o pass incorrectos
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.CerrarConexion();
            }
        }
        public void Registrar(Usuario nuevo)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                // El TipoUsuario 2 significa "Cliente" (el 1 sos vos, el Admin)
                datos.SetearConsulta("INSERT INTO Usuarios (Email, Pass, Nombre, Apellido, Telefono, Direccion, TipoUsuario) VALUES (@email, @pass, @nombre, @apellido, @telefono, @direccion, 2)");

                datos.SetearParametro("@email", nuevo.Email);
                datos.SetearParametro("@pass", nuevo.Pass);

                // Manejo de nulos por si dejan algo vacío (aunque intentaremos que llenen todo)
                datos.SetearParametro("@nombre", nuevo.Nombre ?? (object)DBNull.Value);
                datos.SetearParametro("@apellido", nuevo.Apellido ?? (object)DBNull.Value);
                datos.SetearParametro("@telefono", nuevo.Telefono ?? (object)DBNull.Value);
                datos.SetearParametro("@direccion", nuevo.Direccion ?? (object)DBNull.Value);

                datos.EjecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.CerrarConexion();
            }
        }
    }
}