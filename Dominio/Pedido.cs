using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Pedido
    {
        public int Id { get; set; }
        public Cliente Cliente { get; set; }
        public DateTime Fecha { get; set; }
        public int Total { get; set; }
        public string Estado { get; set; }

        public List<DetallePedido> Detalles { get; set; }

        public Pedido()
        {
            Cliente = new Cliente();
            Detalles = new List<DetallePedido>();
        }
    }
}