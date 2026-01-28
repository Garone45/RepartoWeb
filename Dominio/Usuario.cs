using System;

namespace Dominio
{
    public class Usuario
    {
        public int Id { get; set; }
        public string Email { get; set; }
        public string Pass { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public string Telefono { get; set; }
        public string Direccion { get; set; }
        public int TipoUsuario { get; set; } // 1 = Admin, 2 = Cliente

        // Propiedad extra "solo lectura" para preguntar fácil si es admin
        public bool EsAdmin
        {
            get { return TipoUsuario == 1; }
        }
    }
}