using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ComidasPop
{
    public partial class WFRegistro : System.Web.UI.Page 
    {
        private Conexion conn = new Conexion();
#pragma warning disable CS0414 // El campo 'WFRegistro.dt' está asignado pero su valor nunca se usa
        private DataTable dt = null;
#pragma warning restore CS0414 // El campo 'WFRegistro.dt' está asignado pero su valor nunca se usa
        private String nombres = "";
        private String apellidos = "";
        private String email = "";
        private String password = "";
        private String mensaje = "";

        public string Nombres { get => nombres; set => nombres = value; }
        public string Apellidos { get => apellidos; set => apellidos = value; }
        public string Email { get => email; set => email = value; }
        public string Password { get => password; set => password = value; }
        public string Mensaje { get => mensaje; set => mensaje = value; }

        protected void Page_Load(object sender, EventArgs e)
        {
            conn.ConexionSql(conn.CadenaConexionBD());
        }

        protected void btnCrearCuenta_Click(object sender, EventArgs e)
        {
            if(!txtNombres.Text.Trim().Equals("") && !txtApellidos.Text.Trim().Equals("") && !txtEmail.Text.Trim().Equals("") && !txtPassword.Text.Trim().Equals(""))
            {
                Nombres = txtNombres.Text.Trim();
                Apellidos = txtApellidos.Text.Trim();
                Email = txtEmail.Text.Trim();
                Password = txtPassword.Text.Trim();

                Mensaje = conn.Tabla("dbo.sp_crear_cuenta 1, '" + Nombres + "', '" + Apellidos + "', '" + Email + "', '" + Password + "'").Rows[0]["mensaje"].ToString();

                if(Mensaje.Equals("OK"))
                {
                    txtNombres.Text = "";
                    txtApellidos.Text = "";
                    txtEmail.Text = "";
                    txtPassword.Text = "";
                    //utilizando el SweetAlert for Boostrap     emayorga 15/04/2020
                    ClientScript.RegisterStartupScript(this.GetType(), "mensaje", "<script> swal({ " +
                                                                                                  " title: 'Mensaje', " +
                                                                                                  " text: 'Se ha creado la cuenta con exito', " +
                                                                                                  " type: 'success', " +
                                                                                                  " confirmButtonText: 'Ok', " +
                                                                                                  " closeOnConfirm: false " +
                                                                                                " }, " +
                                                                                                " function(){ " +
                                                                                                "   window.location.href = 'WFLogin.aspx';" +       //con esto me redirecciono a la pagina de login
                                                                                                " }); </script>");
                }
                if (Mensaje.Equals("ERROR"))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "mensaje", "<script>swal('Error', 'Ocurrió un error al tratar de crear la cuenta', 'error')</script>");
                }
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "mensaje", "<script> swal('Advertencia', 'Debe llenar todos los campos para poder crear una cuenta', 'warning') </script>");
            }
        }
    }
}