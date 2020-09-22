using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ComidasPop
{
    public partial class MPPlantilla : System.Web.UI.MasterPage
    {
        private Usuario usuario = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["ses_usuario"] != null)
            {
                usuario = new Usuario();
                usuario = (Usuario)Session["ses_usuario"];
                lblUsuario.Text = usuario.Pro_nombres + " " + usuario.Pro_apellidos;
            }

        }

        protected void ASPxNavBar1_ItemClick(object source, DevExpress.Web.NavBarItemEventArgs e)
        {

        }
    }
}