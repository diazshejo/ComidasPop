using DevExpress.ClipboardSource.SpreadsheetML;
using DevExpress.Utils.Serializing;
using DevExpress.Web.Internal;
using DevExpress.XtraPrinting;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
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
        private Comedor comedor = null;
        private DataTable dt = null;
        private DataTable dtPaises = null;
        private DataTable dtDepartamentos = null;
        private DataTable dtMunicipios = null;
        private DataTable dtComercios = null;
        private int codigo_comercio = 0;
        private String nombre_establecimiento = "";
        private String mensaje = "";
        private int telefono = 0;
        private int codigo_pais = 0;
        private int codigo_departamento = 0;
        private int codigo_municipio = 0;
        private String latitud = "";
        private String longitud = "";
        private int codigo_propietario = 0;

        public string Nombre_establecimiento { get => nombre_establecimiento; set => nombre_establecimiento = value; }
        public int Telefono { get => telefono; set => telefono = value; }
        public int Codigo_pais { get => codigo_pais; set => codigo_pais = value; }
        public int Codigo_departamento { get => codigo_departamento; set => codigo_departamento = value; }
        public int Codigo_municipio { get => codigo_municipio; set => codigo_municipio = value; }
        public String Latitud { get => latitud; set => latitud = value; }
        public String Longitud { get => longitud; set => longitud = value; }
        public string Mensaje { get => mensaje; set => mensaje = value; }
        public int Codigo_propietario { get => codigo_propietario; set => codigo_propietario = value; }
        public int Codigo_comercio { get => codigo_comercio; set => codigo_comercio = value; }

        protected void Page_Load(object sender, EventArgs e)
        {
            conn.ConexionSql(conn.CadenaConexionBD());

            if (!Page.IsPostBack)
            {
                Llenar_Paises();
                
            }
            Llenar_Comercios();
            txtLatitud.Attributes.Add("readonly", "readonly");
            txtLongitud.Attributes.Add("readonly", "readonly");
            //ModalMapaddress.Attributes.Add("readonly", "readonly");
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

        public void Llenar_Departamentos(int codigo_pais)
        {
            dtDepartamentos = new DataTable();

            dtDepartamentos = conn.Tabla("dbo.sp_obtener_departamentos 1, " + Codigo_pais + "");

            ddlDepartamento.DataSource = dtDepartamentos;
            ddlDepartamento.DataTextField = "dep_nombre";
            ddlDepartamento.DataValueField = "dep_id";
            ddlDepartamento.DataBind();

            //Agrego un item en blanco en el combobox para que el usuario se vea obligado a seleccionar el departamento
            ddlDepartamento.Items.Insert(0, new ListItem(String.Empty, String.Empty));
            ddlDepartamento.SelectedIndex = 0;
        }

        public void Llenar_Municipios(int codigo_departamento)
        {
            dtMunicipios = new DataTable();

            dtMunicipios = conn.Tabla("dbo.sp_obtener_municipios 1, " + Codigo_departamento + "");

            ddlMunicipio.DataSource = dtMunicipios;
            ddlMunicipio.DataTextField = "mun_nombre";
            ddlMunicipio.DataValueField = "mun_id";
            ddlMunicipio.DataBind();

            //Agrego un item en blanco en el combobox para que el usuario se vea obligado a seleccionar el departamento
            ddlMunicipio.Items.Insert(0, new ListItem(String.Empty, String.Empty));
            ddlMunicipio.SelectedIndex = 0;
        }

        public void Llenar_Comercios()
        {
            try
            {
                dtComercios = new DataTable();
                dtComercios = conn.Tabla("dbo.sp_obtener_establecimientos_comerciales 1, " + Session["ses_ProId"]);
                gvDatosComercio.DataSource = dtComercios;
                gvDatosComercio.DataBind();
            }
            catch(Exception ex)
            {

            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                //usuario = new Usuario();
                dt = new DataTable();
                //manipulacion de la imagen para guardarla en la BDD, aqui se obtienen los datos de la imagen
                int tamanio = FilePhoto.PostedFile.ContentLength;       //obtengo el tamanio de la imagen que voy a subir
                byte[] imagen_original = new byte[tamanio];             //creo un array del tamanio de la imagen
                FilePhoto.PostedFile.InputStream.Read(imagen_original, 0, tamanio);
                Bitmap imagen_binaria = null;

                if (tamanio > 0)
                {
                    imagen_binaria = new Bitmap(FilePhoto.PostedFile.InputStream);
                }

                //String imagenDataURL64 = "data:image/jpg,base64," + Convert.ToBase64String(imagen_original);
                //imgPreview.ImageUrl = imagenDataURL64;

                //usuario = (Usuario)Session["ses_usuario"];
                Nombre_establecimiento = txtNombre.Text.Trim();
                Telefono = Convert.ToInt32(txtTelefono.Text.Trim());

                if (chkSinUbicacion.Checked)
                {
                    Latitud = "0";
                    Longitud = "0";
                }
                else
                {
                    Latitud = txtLatitud.Text.Trim();
                    Longitud = txtLongitud.Text.Trim();
                }

                Codigo_pais = Convert.ToInt32(ddlPais.SelectedValue.ToString());
                Codigo_departamento = Convert.ToInt32(ddlDepartamento.SelectedValue.ToString());
                Codigo_municipio = Convert.ToInt32(ddlMunicipio.SelectedValue.ToString());
                Codigo_propietario = Convert.ToInt32(Session["ses_ProId"].ToString());

                //Creo los parametros que se le enviaran al procedimiento almacenando.
                SqlParameter pOpcion = new SqlParameter("@opcion", SqlDbType.SmallInt);
                pOpcion.Value = 1;
                SqlParameter pNombre = new SqlParameter("@nombre_comercio", SqlDbType.VarChar);
                pNombre.Value = Nombre_establecimiento;
                SqlParameter pTelefono = new SqlParameter("@telefono", SqlDbType.Int);
                pTelefono.Value = Telefono;
                SqlParameter pLogo = new SqlParameter("@logo", SqlDbType.Image);
                pLogo.Value = imagen_original;
                SqlParameter pLatitud = new SqlParameter("@latitud", SqlDbType.VarChar);
                pLatitud.Value = Latitud;
                SqlParameter pLongitud = new SqlParameter("@longitud", SqlDbType.VarChar);
                pLongitud.Value = Longitud;
                SqlParameter pPais = new SqlParameter("@id_pais", SqlDbType.Int);
                pPais.Value = Codigo_pais;
                SqlParameter pDepartamento = new SqlParameter("@id_departamento", SqlDbType.Int);
                pDepartamento.Value = Codigo_departamento;
                SqlParameter pMunicipio = new SqlParameter("@id_municipio", SqlDbType.Int);
                pMunicipio.Value = Codigo_municipio;
                SqlParameter pPropietario = new SqlParameter("@id_propietario", SqlDbType.Int);
                pPropietario.Value = Codigo_propietario;
                SqlParameter pMensaje = new SqlParameter("@mensaje", SqlDbType.VarChar, 50);

                //Agrego los parametros al sqlcommand
                SqlCommand cmd = new SqlCommand();
                cmd.Parameters.Add(pOpcion);
                cmd.Parameters.Add(pNombre);
                cmd.Parameters.Add(pTelefono);
                cmd.Parameters.Add(pLogo);
                cmd.Parameters.Add(pLatitud);
                cmd.Parameters.Add(pLongitud);
                cmd.Parameters.Add(pPais);
                cmd.Parameters.Add(pDepartamento);
                cmd.Parameters.Add(pMunicipio);
                cmd.Parameters.Add(pPropietario);
                cmd.Parameters.Add(pMensaje).Direction = ParameterDirection.Output;
                SqlConnection conexion = new SqlConnection(conn.CadenaConexionBD());
                conexion.Open();
                cmd.Connection = conexion;
                cmd.CommandText = "dbo.sp_crear_establecimiento_comercial";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.ExecuteNonQuery();
                Mensaje = cmd.Parameters["@mensaje"].Value.ToString();
                conexion.Close();

                //Mensaje = conn.Tabla("dbo.sp_crear_establecimiento_comercial 1, '"+ Nombre_establecimiento +"', "+ Telefono +", "+ parametro +", "+ Latitud +", "+ Longitud +", "+ Codigo_pais +", "+ Codigo_departamento +", "+ Codigo_municipio +", "+ codigo_propietario +"").Rows[0]["mensaje"].ToString();

                if(Mensaje.Equals("OK"))
                {
                    Llenar_Comercios();
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
                ClientScript.RegisterStartupScript(this.GetType(), "mensaje", "<script>swal('Error', 'Ocurrió una excepción en la base de datos al tratar de crear el establecimiento comercial', 'error')</script>");
            }
        }

        protected void ddlPais_SelectedIndexChanged(object sender, EventArgs e)
            {
            //valido que el elemento seleccionado contenga informacion
            if (ddlPais.SelectedValue.Equals(""))
            {
                Codigo_pais = 0;
            }
            else
            {
                Codigo_pais = Convert.ToInt32(ddlPais.SelectedValue.ToString());
            }

            Llenar_Departamentos(Codigo_pais);

            
        }

        protected void ddlDepartamento_SelectedIndexChanged(object sender, EventArgs e)
        {
            //valido que el elemento seleccionado contenga informacion
            if (ddlDepartamento.SelectedValue.Equals(""))
            {
                Codigo_departamento = 0;
            }
            else
            {
                Codigo_departamento = Convert.ToInt32(ddlDepartamento.SelectedValue.ToString());
            }

            Llenar_Municipios(Codigo_departamento);
        }

        protected void gvDatosComercio_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            comedor = new Comedor();
            int fila = Convert.ToInt32(e.CommandArgument);

            comedor.Com_id = Convert.ToInt32(gvDatosComercio.DataKeys[fila].Values[0].ToString());
            comedor.Com_nombre = gvDatosComercio.DataKeys[fila].Values[1].ToString();
            comedor.Com_telefono = gvDatosComercio.DataKeys[fila].Values[2].ToString();
            if(gvDatosComercio.DataKeys[fila].Values[3].ToString().Equals("Activo"))
            {
                comedor.Com_estado = 'A';
            }
            if(gvDatosComercio.DataKeys[fila].Values[3].ToString().Equals("Inactivo"))
            {
                comedor.Com_estado = 'I';
            }
            //comedor.Com_estado = Convert.ToChar(gvDatosComercio.DataKeys[fila].Values[3].ToString());
            comedor.Com_latitud = gvDatosComercio.DataKeys[fila].Values[6].ToString();
            comedor.Com_longitud = gvDatosComercio.DataKeys[fila].Values[7].ToString();
            comedor.Pai_id = Convert.ToInt32(gvDatosComercio.DataKeys[fila].Values[8].ToString());
            comedor.Dep_id = Convert.ToInt32(gvDatosComercio.DataKeys[fila].Values[9].ToString());
            comedor.Mun_id = Convert.ToInt32(gvDatosComercio.DataKeys[fila].Values[10].ToString());
            comedor.Pro_id = Convert.ToInt32(gvDatosComercio.DataKeys[fila].Values[11].ToString());
            comedor.Nombre_pais = gvDatosComercio.DataKeys[fila].Values[12].ToString();
            comedor.Nombre_departamento = gvDatosComercio.DataKeys[fila].Values[13].ToString();
            comedor.Nombre_municipio = gvDatosComercio.DataKeys[fila].Values[14].ToString();

            Session["ses_Comedor"] = comedor;

            //Response.Redirect("WFEditarComedor.aspx");
        }

        protected void chkSinUbicacion_CheckedChanged(object sender, EventArgs e)
        {
            if(chkSinUbicacion.Checked)
            {
                btnMapa.Disabled = true;
                Latitud = "0";
                longitud = "0";
            }
            else
            {
                btnMapa.Disabled = false;
                Latitud = txtLatitud.Text.Trim();
                Longitud = txtLongitud.Text.Trim();
            }
        }
    }
}