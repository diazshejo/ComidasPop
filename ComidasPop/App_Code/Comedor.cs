using Org.BouncyCastle.Utilities.Encoders;
using System;
using System.Collections.Generic;
using System.Linq; 
using System.Web;

namespace ComidasPop
{
    public class Comedor
    {
        private int com_id = 0;
        private String com_nombre = "";
        private String com_telefono = "";
        private byte[] com_logo = null;
        private String com_latitud = "";
        private String com_longitud = "";
        private int pai_id = 0;
        private int dep_id = 0;
        private int mun_id = 0;
        private int pro_id = 0;
        private char com_estado = 'A';
        private String nombre_pais = "";
        private String nombre_departamento = "";
        private String nombre_municipio = "";
        private String com_direccion = "";
        private int com_zona = 0;

        public int Com_id { get => com_id; set => com_id = value; }
        public string Com_nombre { get => com_nombre; set => com_nombre = value; }
        public string Com_telefono { get => com_telefono; set => com_telefono = value; }
        public byte[] Com_logo { get => com_logo; set => com_logo = value; }
        public string Com_latitud { get => com_latitud; set => com_latitud = value; }
        public string Com_longitud { get => com_longitud; set => com_longitud = value; }
        public int Pai_id { get => pai_id; set => pai_id = value; }
        public int Dep_id { get => dep_id; set => dep_id = value; }
        public int Mun_id { get => mun_id; set => mun_id = value; }
        public int Pro_id { get => pro_id; set => pro_id = value; }
        public char Com_estado { get => com_estado; set => com_estado = value; }
        public string Nombre_pais { get => nombre_pais; set => nombre_pais = value; }
        public string Nombre_departamento { get => nombre_departamento; set => nombre_departamento = value; }
        public string Nombre_municipio { get => nombre_municipio; set => nombre_municipio = value; }
        public string Com_direccion { get => com_direccion; set => com_direccion = value; }
        public int Com_zona { get => com_zona; set => com_zona = value; }
    }
}