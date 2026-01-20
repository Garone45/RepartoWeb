using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Producto
    {
        public int Id { get; set; }
        public string Nombre { get; set; }
        public int Precio { get; set; }
        public string Unidad { get; set; }
        public bool Activo { get; set; }
        public string Descripcion { get; set; }

        // Relación: Un producto tiene una categoría
        public Categoria Categoria { get; set; }

        public Producto()
        {
            Categoria = new Categoria();
        }
    }
}