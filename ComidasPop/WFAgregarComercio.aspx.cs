using DevExpress.Utils.Serializing;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ComidasPop
{
    public partial class WFAgregarComercio : System.Web.UI.Page
    {
        private Conexion conn = new Conexion();
        private Usuario usuario = null;
        private DataTable dt = null;
        private DataTable dtPaises = null;
        private DataTable dtDepartamentos = null;
        private DataTable dtMunicipios = null;
        private String nombre_establecimiento = "";
        private String mensaje = "";
        private int telefono = 0;
        private int codigo_pais = 0;
        private int codigo_departamento = 0;
        private int codigo_municipio = 0;
        private double latitud = 0.0;
        private double longitud = 0.0;
        private int codigo_propietario = 0;

        public string Nombre_establecimiento { get => nombre_establecimiento; set => nombre_establecimiento = value; }
        public int Telefono { get => telefono; set => telefono = value; }
        public int Codigo_pais { get => codigo_pais; set => codigo_pais = value; }
        public int Codigo_departamento { get => codigo_departamento; set => codigo_departamento = value; }
        public int Codigo_municipio { get => codigo_municipio; set => codigo_municipio = value; }
        public double Latitud { get => latitud; set => latitud = value; }
        public double Longitud { get => longitud; set => longitud = value; }
        public string Mensaje { get => mensaje; set => mensaje = value; }
        public int Codigo_propietario { get => codigo_propietario; set => codigo_propietario = value; }

        protected void Page_Load(object sender, EventArgs e)
        {
            conn.ConexionSql(conn.CadenaConexionBD());
            if (!Page.IsPostBack)
            {
                Llenar_Paises();
            }
        }

        public void Llenar_Paises()
        {
            dtPaises = new DataTable();
            dtPaises = conn.Tabla("dbo.sp_obtener_paises 1");
            ddlPais.DataSource = dtPaises;
            
            ddlPais.DataTextField = "pai_nombre";
            ddlPais.DataValueField = "pai_id";
            ddlPais.DataBind();
            //Agrego un item en blanco en el combobox para que el usuario se vea obligado a seleccionar el pais
            ddlPais.Items.Insert(0, new ListItem(String.Empty, String.Empty));
            ddlPais.SelectedIndex = 0;
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                usuario = new Usuario();
                dt = new DataTable();

                usuario = (Usuario)Session["ses_usuario"];
                Nombre_establecimiento = txtNombre.Text.Trim();
                Telefono = Convert.ToInt32(txtTelefono.Text.Trim());
                Latitud = Convert.ToDouble(txtLatitud.Text.Trim());
                Longitud = Convert.ToDouble(txtLongitud.Text.Trim());
                Codigo_pais = Convert.ToInt32(ddlPais.SelectedValue.ToString());
                Codigo_departamento = Convert.ToInt32(ddlDepartamento.SelectedValue.ToString());
                Codigo_municipio = Convert.ToInt32(ddlMunicipio.SelectedValue.ToString());
                Codigo_propietario = Convert.ToInt32(usuario.Pro_id);

                Mensaje = conn.Tabla("dbo.sp_crear_establecimiento_comercial 1, '"+ Nombre_establecimiento +"', "+ Telefono +", null, "+ Latitud +", "+ Longitud +", "+ Codigo_pais +", "+ Codigo_departamento +", "+ Codigo_municipio +", "+ codigo_propietario +"").Rows[0]["mensaje"].ToString();

                if(Mensaje.Equals("OK"))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "mensaje", "<script> swal({ " +
                                                                                                  " title: 'Mensaje', " +
                                                                                                  " text: 'Se ha registrado el comercio con éxito', " +
                                                                                                  " type: 'success', " +
                                                                                                  " confirmButtonText: 'Ok', " +
                                                                                                  " closeOnConfirm: false " +
                                                                                                " }, " +
                                                                                                " function(){ " +
                                                                                                "   window.location.href = 'WFAgregarComercio.aspx';" +       //con esto me redirecciono a la pagina de login
                                                                                                " }); </script>");
                }
                if(Mensaje.Equals("ERROR"))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "mensaje", "<script>swal('Error', 'Ocurrió un error al tratar de crear el establecimiento comercial', 'error')</script>");
                }
            }
            catch(Exception ex)
            {

            }
        }

        protected void ddlPais_SelectedIndexChanged(object sender, EventArgs e)
        {
            dtDepartamentos = new DataTable();
            //valido que el elemento seleccionado contenga informacion
            if (ddlPais.SelectedValue.Equals(""))
            {
                Codigo_pais = 0;
            }
            else
            {
                Codigo_pais = Convert.ToInt32(ddlPais.SelectedValue.ToString());
            }

            dtDepartamentos = conn.Tabla("dbo.sp_obtener_departamentos 1, "+ Codigo_pais +"");

            ddlDepartamento.DataSource = dtDepartamentos;
            ddlDepartamento.DataTextField = "dep_nombre";
            ddlDepartamento.DataValueField = "dep_id";
            ddlDepartamento.DataBind();

            //Agrego un item en blanco en el combobox para que el usuario se vea obligado a seleccionar el departamento
            ddlDepartamento.Items.Insert(0, new ListItem(String.Empty, String.Empty));
            ddlDepartamento.SelectedIndex = 0;
        }

        protected void ddlDepartamento_SelectedIndexChanged(object sender, EventArgs e)
        {
            dtMunicipios = new DataTable();
            //valido que el elemento seleccionado contenga informacion
            if (ddlDepartamento.SelectedValue.Equals(""))
            {
                Codigo_departamento = 0;
            }
            else
            {
                Codigo_departamento = Convert.ToInt32(ddlDepartamento.SelectedValue.ToString());
            }

            dtMunicipios = conn.Tabla("dbo.sp_obtener_municipios 1, " + Codigo_departamento + "");

            ddlMunicipio.DataSource = dtMunicipios;
            ddlMunicipio.DataTextField = "mun_nombre";
            ddlMunicipio.DataValueField = "mun_id";
            ddlMunicipio.DataBind();

            //Agrego un item en blanco en el combobox para que el usuario se vea obligado a seleccionar el departamento
            ddlMunicipio.Items.Insert(0, new ListItem(String.Empty, String.Empty));
            ddlMunicipio.SelectedIndex = 0;
        }
    }
}