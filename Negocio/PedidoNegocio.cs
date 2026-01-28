using System;
using System.Collections.Generic;
using Dominio;

namespace Negocio
{
    public class PedidoNegocio
    {
        public List<Pedido> ListarPorUsuario(int idUsuario)
        {
            List<Pedido> lista = new List<Pedido>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                // Traemos también la columna 'Cliente' (nombre) por si querés mostrarla
                datos.SetearConsulta("SELECT Id, Fecha, Total, Direccion, Cliente FROM Pedidos WHERE IdUsuario = @idUser ORDER BY Fecha DESC");
                datos.SetearParametro("@idUser", idUsuario);

                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    Pedido aux = new Pedido();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.Fecha = (DateTime)datos.Lector["Fecha"];
                    aux.Total = (decimal)datos.Lector["Total"];

                    // CORRECCIÓN: Asignamos directo a las propiedades string
                    if (!(datos.Lector["Direccion"] is DBNull))
                        aux.Direccion = (string)datos.Lector["Direccion"];

                    if (!(datos.Lector["Cliente"] is DBNull))
                        aux.NombreCliente = (string)datos.Lector["Cliente"];

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
        public List<DetallePedido> ListarDetalle(int idPedido)
        {
            List<DetallePedido> lista = new List<DetallePedido>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                // CORRECCIÓN: 
                // Ya no hacemos JOIN con Productos porque a veces no tenemos el ID.
                // Leemos directamente de la tabla DetallesPedido que ya tiene el nombre y precio congelado.
                datos.SetearConsulta("SELECT NombreProducto, PrecioUnitario, Cantidad FROM DetallesPedido WHERE IdPedido = @id");
                datos.SetearParametro("@id", idPedido);
                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    DetallePedido detalle = new DetallePedido();
                    detalle.Producto = new Producto();

                    // Leemos el nombre guardado en el detalle
                    detalle.Producto.Nombre = (string)datos.Lector["NombreProducto"];

                    // Leemos el precio histórico (lo que valía cuando lo compró)
                    // Ojo con los tipos de datos: DB es Decimal -> C# Int
                    decimal precioDecimal = (decimal)datos.Lector["PrecioUnitario"];
                    detalle.PrecioUnitario = (int)precioDecimal;

                    detalle.Cantidad = (int)datos.Lector["Cantidad"];

                    lista.Add(detalle);
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