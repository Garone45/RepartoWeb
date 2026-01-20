using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class ProductoNegocio
    {
        // 1. MÉTODO LISTAR (Lectura con JOIN)
        public List<Producto> Listar()
        {
            List<Producto> lista = new List<Producto>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                // ACÁ ESTÁ EL TRUCO:
                // Traemos todo de Productos (P) y el Nombre de la Categoría (C)
                // Usamos "C.Nombre as CategoriaNombre" para que no se mezcle con P.Nombre
                datos.SetearConsulta(@"SELECT P.Id, P.Nombre, P.Precio, P.Unidad, P.Activo, P.Descripcion, 
                                       P.IdCategoria, C.Nombre as CategoriaNombre
                                       FROM Productos P 
                                       INNER JOIN Categorias C ON P.IdCategoria = C.Id");

                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    Producto aux = new Producto();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Precio = (int)datos.Lector["Precio"];
                    aux.Unidad = (string)datos.Lector["Unidad"];
                    aux.Activo = (bool)datos.Lector["Activo"];

                    // Validamos la descripción porque permite nulos en la DB
                    if (!(datos.Lector["Descripcion"] is DBNull))
                        aux.Descripcion = (string)datos.Lector["Descripcion"];

                    // MAPEO DE LA RELACIÓN (Objeto dentro de Objeto)
                    // Acá llenamos la propiedad 'Categoria' que está dentro de Producto
                    aux.Categoria.Id = (int)datos.Lector["IdCategoria"];
                    aux.Categoria.Nombre = (string)datos.Lector["CategoriaNombre"];

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

        // 2. MÉTODO AGREGAR (Insertar nuevo)
        public void Agregar(Producto nuevo)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.SetearConsulta("INSERT INTO Productos (Nombre, Precio, Unidad, Activo, IdCategoria, Descripcion) VALUES (@nombre, @precio, @unidad, 1, @idCat, @desc)");

                // Pasamos los valores de forma segura (evita inyección SQL)
                datos.SetearParametro("@nombre", nuevo.Nombre);
                datos.SetearParametro("@precio", nuevo.Precio);
                datos.SetearParametro("@unidad", nuevo.Unidad);
                datos.SetearParametro("@idCat", nuevo.Categoria.Id);

                // Si la descripción es nula, mandamos DBNull
                if (string.IsNullOrEmpty(nuevo.Descripcion))
                    datos.SetearParametro("@desc", DBNull.Value);
                else
                    datos.SetearParametro("@desc", nuevo.Descripcion);

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
