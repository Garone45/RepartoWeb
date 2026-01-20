using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Categoria
    {
        public int Id { get; set; }
        public string Nombre { get; set; }
        public int Orden { get; set; }

        // Esto hace la magia visual en los controles web
        public override string ToString()
        {
            return Nombre;
        }
    }
}
