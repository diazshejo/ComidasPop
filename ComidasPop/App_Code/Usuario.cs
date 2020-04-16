using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ComidasPop
{
    public class Usuario
    {
        private int pro_id;
        private String pro_nombres;
        private String pro_apellidos;
        private String usu_nombre;
        private String usu_password;
        private String usu_email;
        private DateTime usu_fecha_alta;
        private Char usu_estado;

        public Usuario()
        {

        }

        public int Pro_id { get => pro_id; set => pro_id = value; }
        public string Pro_nombres { get => pro_nombres; set => pro_nombres = value; }
        public string Pro_apellidos { get => pro_apellidos; set => pro_apellidos = value; }
        public string Usu_nombre { get => usu_nombre; set => usu_nombre = value; }
        public string Usu_password { get => usu_password; set => usu_password = value; }
        public string Usu_email { get => usu_email; set => usu_email = value; }
        public DateTime Usu_fecha_alta { get => usu_fecha_alta; set => usu_fecha_alta = value; }
        public char Usu_estado { get => usu_estado; set => usu_estado = value; }
    }
}