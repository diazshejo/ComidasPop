using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ComidasPop
{
    public partial class WFLogin : System.Web.UI.Page
    {
        private Conexion conn = new Conexion();
        private Usuario usuario = null;
        private DataTable dt = null;
        private String email = "";
        private String password = "";
        private String mensaje = "";

        public string Email { get => email; set => email = value; }
        public string Password { get => password; set => password = value; }
        public string Mensaje { get => mensaje; set => mensaje = value; }

        protected void Page_Load(object sender, EventArgs e)
        {
            conn.ConexionSql(conn.CadenaConexionBD());
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if(!txtEmail.Text.Trim().Equals("") && !txtPassword.Text.Trim().Equals(""))
            {
                Email = txtEmail.Text.Trim();
                password = txtPassword.Text.Trim();

                Mensaje = conn.Tabla("dbo.sp_validar_login " + "'"+Email+"', " + "'"+ Password +"'").Rows[0]["mensaje"].ToString();

                if(Mensaje.Equals("VALIDO"))
                {
                    //obtengo los datos del usuario.
                    dt = new DataTable();
                    usuario = new Usuario();

                    dt = conn.Tabla("dbo.sp_obtener_informacion_usuarios 1, " + "'"+ Email +"'");

                    usuario.Pro_id = Convert.ToInt32(dt.Rows[0]["pro_id"].ToString());
                    usuario.Pro_nombres = dt.Rows[0]["pro_nombres"].ToString();
                    usuario.Pro_apellidos = dt.Rows[0]["pro_apellidos"].ToString();
                    usuario.Usu_nombre = dt.Rows[0]["usu_nombre"].ToString();
                    usuario.Usu_password = dt.Rows[0]["usu_password"].ToString();
                    usuario.Usu_email = dt.Rows[0]["usu_email"].ToString();
                    usuario.Usu_fecha_alta = Convert.ToDateTime(dt.Rows[0]["usu_fecha_alta"].ToString());
                    usuario.Usu_estado = Convert.ToChar(dt.Rows[0]["usu_estado"].ToString());

                    Session["ses_usuario"] = usuario;       //creo una variable de sesion

                    //Response.Redirect("WFPrincipal.aspx");
                }
                if(Mensaje.Equals("INVALIDO"))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "mensaje", "<script> swal('Advertencia', 'Usuario o contraseña no validos.', 'warning') </script>");
                }
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "mensaje", "<script> swal('Advertencia', 'Debe llenar todos los campos para poder ingresar al sistema', 'warning') </script>");
            }
        }
    }
}