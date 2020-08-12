using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ComidasPop
{
    public partial class WFPrincipal : System.Web.UI.Page
    {
        private Usuario usuario = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Session["ses_usuario"] != null)
                {
                    usuario = new Usuario();
                    usuario = (Usuario)Session["ses_usuario"];

                    Session["ses_ProId"] = usuario.Pro_id;
                }
            }
        }
    }
}