using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace Negocio
{
    public class CategoriaNegocio
    {
        public List<Categoria> Listar()
        {
            List<Categoria> lista = new List<Categoria>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                // La consulta SQL directa
                datos.SetearConsulta("SELECT Id, Nombre, Orden FROM Categorias ORDER BY Orden");
                datos.EjecutarLectura();

                // Recorremos el lector
                while (datos.Lector.Read())
                {
                    Categoria aux = new Categoria();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.Nombre = (string)datos.Lector["Nombre"];

                    // Validamos nulos por las dudas (aunque en DB pusimos NOT NULL)
                    if (!(datos.Lector["Orden"] is DBNull))
                        aux.Orden = (int)datos.Lector["Orden"];

                    lista.Add(aux);
                }

                return lista;
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