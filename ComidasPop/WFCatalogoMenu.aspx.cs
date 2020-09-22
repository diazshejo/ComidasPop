using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ComidasPop
{
    public partial class WFCatalogoMenu : System.Web.UI.Page
    {
        private Conexion conn = new Conexion();
        private DataTable dtCatalogoMenu = null;
        private DataTable dtComercios = null;
        private DataTable dtCategorias = null;
        private int id_comedor = 0;
        private int id_categoria = 0;

        public int Id_comedor { get => id_comedor; set => id_comedor = value; }
        public int Id_categoria { get => id_categoria; set => id_categoria = value; }

        protected void Page_Load(object sender, EventArgs e)
        {
            conn.ConexionSql(conn.CadenaConexionBD());
            if(!Page.IsPostBack)
            {
                LlenarComedores();
                LlenarCategorias();
            }
        }

        protected void CargarMenus(int opcion, int id_categoria, int id_comedor)
        {
            dtCatalogoMenu = new DataTable();
            dtCatalogoMenu = conn.Tabla("dbo.sp_obtener_catalogo_menu_x_negocio " + opcion + ", " + id_categoria + ", " + id_comedor);
            repetidor.DataSource = dtCatalogoMenu;
            repetidor.DataBind();
        }

        public void LlenarComedores()
        {
            int codigo_propietario = Convert.ToInt32(Session["ses_ProId"].ToString());
            dtComercios = new DataTable();
            dtComercios = conn.Tabla("dbo.sp_obtener_comedores_x_propietario 1, " + codigo_propietario);
            ddlComercio.DataSource = dtComercios;

            ddlComercio.DataTextField = "com_nombre";
            ddlComercio.DataValueField = "com_id";
            ddlComercio.DataBind();
            //Agrego un item en blanco en el combobox para que el usuario se vea obligado a seleccionar la categoria
            ddlComercio.Items.Insert(0, new ListItem(String.Empty, String.Empty));
            ddlComercio.SelectedIndex = 0;
        }

        public void LlenarCategorias()
        {
            dtCategorias = new DataTable();
            dtCategorias = conn.Tabla("dbo.sp_obtener_categorias 1");
            ddlCategoria.DataSource = dtCategorias;

            ddlCategoria.DataTextField = "cat_nombre";
            ddlCategoria.DataValueField = "cat_id";
            ddlCategoria.DataBind();
            //Agrego un item en blanco en el combobox para que el usuario se vea obligado a seleccionar la categoria
            ddlCategoria.Items.Insert(0, new ListItem(String.Empty, String.Empty));
            ddlCategoria.SelectedIndex = 0;
        }

        protected void ddlComercio_SelectedIndexChanged(object sender, EventArgs e)
        {
            Id_comedor = Convert.ToInt32(ddlComercio.SelectedValue.ToString());
            Session["s_IdComedor"] = Id_comedor;
            CargarMenus(1, 1, Id_comedor); //carga todos las imagenes de todos los menus de un comedor
        }

        protected void ddlCategoria_SelectedIndexChanged(object sender, EventArgs e)
        {
            Id_categoria = Convert.ToInt32(ddlCategoria.SelectedValue.ToString());
            Id_comedor = Convert.ToInt32(Session["s_IdComedor"].ToString());
            CargarMenus(2, Id_categoria, Id_comedor);  //carga todas las imagenes de un comedor de una categoria
        }
    }
}