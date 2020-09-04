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

        protected void Page_Load(object sender, EventArgs e)
        {
            conn.ConexionSql(conn.CadenaConexionBD());
            ConsultarImagen();
        }

        public System.Drawing.Image RedimensionarImagen(System.Drawing.Image ImagenOriginal, int alto)
        {
            var radio = (double)alto / ImagenOriginal.Height;
            var nuevoAncho = (int)(ImagenOriginal.Width * radio);
            var nuevoAlto = (int)(ImagenOriginal.Height * radio);
            var NuevaImagenRedimensionada = new Bitmap(nuevoAncho, nuevoAlto);
            var g = Graphics.FromImage(NuevaImagenRedimensionada);
            g.DrawImage(ImagenOriginal, 0, 0, nuevoAncho, nuevoAlto);
            return NuevaImagenRedimensionada;
        }

        protected void ConsultarImagen()
        {
            dtCatalogoMenu = new DataTable();
            dtCatalogoMenu = conn.Tabla("dbo.sp_obtener_catalogo_menu_x_negocio 1, 1, 2");
            repetidor.DataSource = dtCatalogoMenu;
            repetidor.DataBind();
        }
    }
}