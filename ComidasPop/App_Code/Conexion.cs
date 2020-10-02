using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient; 
using System.Linq;
using System.Web;

namespace ComidasPop
{
    public class Conexion
    {
        private SqlConnection conexionBD;
#pragma warning disable CS0414 // El campo 'Conexion.mensaje' está asignado pero su valor nunca se usa
        private String mensaje = "";
#pragma warning restore CS0414 // El campo 'Conexion.mensaje' está asignado pero su valor nunca se usa
#pragma warning disable CS0414 // El campo 'Conexion.mensajeEx' está asignado pero su valor nunca se usa
        private String mensajeEx = "";
#pragma warning restore CS0414 // El campo 'Conexion.mensajeEx' está asignado pero su valor nunca se usa
        private String ip_servidor_db = "";
        // sjs 
        private String clave_server_db = "";
        private String usuario_server_db = "";
        private String nombre_db = "";

        public Conexion()
        {
        }

        public void ConexionSql(string cadena)
        {
            conexionBD = new SqlConnection();
            conexionBD.ConnectionString = cadena;
        }

        public string CadenaConexionBD()
        {
            //Obtengo el valor de las configuraciones guardadas en el web.config
            ip_servidor_db = ConfigurationManager.AppSettings.Get("ip_servidor_db");
            clave_server_db = ConfigurationManager.AppSettings.Get("clave_server_db");
            usuario_server_db = ConfigurationManager.AppSettings.Get("usuario_server_db");
            nombre_db = ConfigurationManager.AppSettings.Get("nombre_db");
            string ConxBd = "";
            //ConxBd += " Data Source=172.16.152.30; Initial Catalog=37_Senoriales_Final;Persist Security Info=True;User ID=sa; Password=principalsap#9";
            ConxBd += " Data Source = " + ip_servidor_db + "; Initial Catalog=" + nombre_db + "; Persist Security Info=True; User ID=" + usuario_server_db + "; Password=" + clave_server_db + "";
            return ConxBd;
        }

        public DataTable Tabla(string Consulta)
        {
            SqlDataAdapter DTA = new SqlDataAdapter();
            DataTable DT = new DataTable();
            SqlCommand CMD = new SqlCommand();

            try
            {
                CMD.Connection = conexionBD;
                CMD.Connection.Open();
                CMD.CommandType = CommandType.Text;
                CMD.CommandText = Consulta;
                CMD.CommandTimeout = 0;
                DTA.SelectCommand = CMD;
                DTA.Fill(DT);
                CMD.Connection.Close();
            }
#pragma warning disable CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            catch (SqlException ex)
#pragma warning restore CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            {
            }
            finally
            {
                DTA.Dispose();
                CMD.Connection.Close();
            }

            return DT;
        }
    }
}