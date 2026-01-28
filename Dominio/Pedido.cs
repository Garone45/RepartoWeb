using System;
using System.Collections.Generic;

namespace Dominio
{
    public class Pedido
    {
        public int Id { get; set; }
        public int IdUsuario { get; set; } // Para saber de quién es
        public DateTime Fecha { get; set; }

        // CAMBIO: Ya no usamos la clase Cliente, usamos strings directos
        public string NombreCliente { get; set; } // Columna "Cliente" en DB
        public string Direccion { get; set; }     // Columna "Direccion" en DB

        public decimal Total { get; set; } // Acordate que lo pasamos a Decimal
        public string Estado { get; set; }

        public List<DetallePedido> Detalles { get; set; }

        public Pedido()
        {
            Detalles = new List<DetallePedido>();
        }
    }
}