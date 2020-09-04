using DevExpress.ClipboardSource.SpreadsheetML;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ComidasPop
{
    public partial class WFAgregarMenu : System.Web.UI.Page
    {
        private Conexion conn = new Conexion();
        private DataTable dtAuxiliar = new DataTable();
        private DataTable dtMenu = null;
        private DataTable dtCategorias = null;
        private DataTable dtComercios = null;
        private int contadorFilaMenu = 0;
        private int codigo_comedor = 0;
        private int codigo_categoria = 0;
        private String mensaje = "";

        public int Codigo_comedor { get => codigo_comedor; set => codigo_comedor = value; }
        public int Codigo_categoria { get => codigo_categoria; set => codigo_categoria = value; }
        public string Mensaje { get => mensaje; set => mensaje = value; }

        protected void Page_Load(object sender, EventArgs e)
        {
            conn.ConexionSql(conn.CadenaConexionBD());

            if(!Page.IsPostBack)
            {
                LlenarCategorias();
                LlenarComedores();
                Session["sContadorFila"] = 0;
                Session["sDtMenu"] = InicializaDTMenu();
                gvMenu.DataSource = (DataTable)Session["sDtMenu"];
                gvMenu.DataBind();
                divCargaMenu.Visible = false;
            }
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

        public void LlenarComedores()
        {
            int codigo_propietario = Convert.ToInt32(Session["ses_ProId"].ToString());
            dtComercios = new DataTable();
            dtComercios = conn.Tabla("dbo.sp_obtener_comedores_x_propietario 1, " + codigo_propietario);
            ddlComedor.DataSource = dtComercios;

            ddlComedor.DataTextField = "com_nombre";
            ddlComedor.DataValueField = "com_id";
            ddlComedor.DataBind();
            //Agrego un item en blanco en el combobox para que el usuario se vea obligado a seleccionar la categoria
            ddlComedor.Items.Insert(0, new ListItem(String.Empty, String.Empty));
            ddlComedor.SelectedIndex = 0;
        }

        public DataTable InicializaDTMenu()
        {
            dtMenu = new DataTable();
            dtMenu.PrimaryKey = new DataColumn[] { dtMenu.Columns.Add("ID", typeof(int)) };     //creo la lleve primaria del datatable
            dtMenu.Columns.Add("nombre_menu", typeof(TextBox));
            dtMenu.Columns.Add("descripcion_menu", typeof(TextBox));
            dtMenu.Columns.Add("precio_menu", typeof(TextBox));
            dtMenu.Columns.Add("imagen_menu", typeof(FileUpload));
            Session["sContadorFila"] = contadorFilaMenu;

            return dtMenu;
        }

        public void InsertarFilaDtMenu()
        {
            TextBox nombre_menu = new TextBox();
            TextBox descripcion_menu = new TextBox();
            TextBox precio_menu = new TextBox();
            FileUpload imagen_menu = new FileUpload();
            DataRow drFila = ((DataTable)Session["sDtMenu"]).NewRow();

            drFila[0] = Convert.ToInt16(Session["sContadorFila"].ToString()) + 1;
            drFila[1] = nombre_menu;
            drFila[2] = descripcion_menu;
            drFila[3] = precio_menu;
            drFila[4] = imagen_menu;
            //incremento el contador de la fila
            Session["sContadorFila"] = Convert.ToInt16(Session["sContadorFila"].ToString()) + 1;
            //agrego la fila al datatable
            ((DataTable)Session["sDtMenu"]).Rows.Add(drFila);
        }

        public void InsertarFilaDtAuxiliar()
        {
            TextBox nombre_menu = new TextBox();
            TextBox descripcion_menu = new TextBox();
            TextBox precio_menu = new TextBox();
            FileUpload imagen_menu = new FileUpload();
            imagen_menu.Width = Unit.Pixel(83);
            DataRow drFila = dtAuxiliar.NewRow();//((DataTable)Session["sDtAuxiliar"]).NewRow();

            drFila[0] = Convert.ToInt16(Session["sContadorFila"].ToString()) + 1;
            drFila[1] = nombre_menu;
            drFila[2] = descripcion_menu;
            drFila[3] = precio_menu;
            drFila[4] = imagen_menu;
            //incremento el contador de la fila
            Session["sContadorFila"] = Convert.ToInt16(Session["sContadorFila"].ToString()) + 1;
            //agrego la fila al datatable
            dtAuxiliar.Rows.Add(drFila);
        }

        protected void btnAgregarFila_Click(object sender, EventArgs e)
        {
            try
            {
                int numero_fila = Convert.ToInt16(seCantidad.Text.Trim());

                if(numero_fila > 0)
                {
                    dtAuxiliar = InicializaDTMenu();    //inicializo la tabla auxiliar, esta se limpia cada vez que carga la pagina.

                    for (int i = 0; i < numero_fila; i++)
                    {
                        InsertarFilaDtAuxiliar();
                    }
                    //seCantidad.Text = "1";
                    Session["sDtMenu"] = dtAuxiliar;
                    gvMenu.DataSource = (DataTable)Session["sDtMenu"];
                    gvMenu.DataBind();
                }
            }
            catch(Exception ex)
            {

            }
            
            /*String vNombreMenu = "";
            String vDescripcionMenu = "";
            String vPrecioMenu = "";
            String vImagen = "";
            int tamanio_imagen = 0;
            byte[] imagen_original = null;
            dtAuxiliar = InicializaDTMenu();    //inicializo la tabla auxiliar, esta se limpia cada vez que carga la pagina.
            //valido si la tabla auxiliar en memoria lleva filas, que las limpie todas
            if(dtAuxiliar.Rows.Count > 0)
            {
                dtAuxiliar.Rows.Clear();
            }
            //si el datatable ya tiene una fila
            if (((DataTable)Session["sDtMenu"]).Rows.Count > 0)
            {
                for (int i = 0; i < ((DataTable)Session["sDtMenu"]).Rows.Count; i++)
                {
                    TextBox txtNombre = (TextBox)gvMenu.Rows[i].FindControl("txtNombre");
                    TextBox txtDescripcion = (TextBox)gvMenu.Rows[i].FindControl("txtDescripcion");
                    TextBox txtPrecio = (TextBox)gvMenu.Rows[i].FindControl("txtPrecio");
                    FileUpload fuImagen = (FileUpload)gvMenu.Rows[i].FindControl("fuImagen");
                    DataRow drFila = dtAuxiliar.NewRow();

                    vNombreMenu = txtNombre.Text.Trim();
                    vDescripcionMenu = txtDescripcion.Text.Trim();
                    vPrecioMenu = txtPrecio.Text.Trim();
                    //vImagen = fuImagen.FileName;

                    TextBox nombre_menu = new TextBox();
                    TextBox descripcion_menu = new TextBox();
                    TextBox precio_menu = new TextBox();
                    FileUpload imagen_menu = new FileUpload();

                    nombre_menu.Text = vNombreMenu;
                    descripcion_menu.Text = vDescripcionMenu;
                    precio_menu.Text = vPrecioMenu;

                    drFila[0] = Convert.ToInt16(Session["sContadorFila"].ToString());
                    drFila[1] = nombre_menu;
                    drFila[2] = descripcion_menu;
                    drFila[3] = precio_menu;
                    drFila[4] = imagen_menu;
                    //incremento el contador de la fila
                    Session["sContadorFila"] = Convert.ToInt16(Session["sContadorFila"].ToString()) + 1;
                    //agrego la fila al datatable
                    dtAuxiliar.Rows.Add(drFila);
                }
                //inserto una fila en blanco al final del DataTable
                InsertarFilaDtAuxiliar();
                //Limpio o quito todas las filas del DataTable que se mostrara en pantalla
                ((DataTable)Session["sDtMenu"]).Clear();
                //Asigno las filas del DataTable Auxiliar al DataTable que se mostrara en pantalla
                Session["sDtMenu"] = dtAuxiliar;

                gvMenu.DataSource = ((DataTable)Session["sDtMenu"]);
                gvMenu.DataBind();
            }
            else   //si el datatable no tiene filas y es la primera vez.
            {
                //inserto una fila en blanco en el DataTable que se muestra en pantalla
                InsertarFilaDtMenu();
                gvMenu.DataSource = (DataTable)Session["sDtMenu"];
                gvMenu.DataBind();
            }*/
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

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            int total_registros = 0;
            String nombre_menu = "";
            String descripcion_menu = "";
            Double precio_menu = 0;
            int tamanio_imagen = 0;
            byte[] imagen_original = null;

            total_registros = ((DataTable)Session["sDtMenu"]).Rows.Count;

            try
            {
                if (((DataTable)Session["sDtMenu"]).Rows.Count > 0)
                {
                    //recorro los controles del gridview y obtengo los valores que le ingrese
                    for (int i = 0; i < ((DataTable)Session["sDtMenu"]).Rows.Count; i++)
                    {
                        TextBox txtNombre = (TextBox)gvMenu.Rows[i].FindControl("txtNombre");
                        TextBox txtDescripcion = (TextBox)gvMenu.Rows[i].FindControl("txtDescripcion");
                        TextBox txtPrecio = (TextBox)gvMenu.Rows[i].FindControl("txtPrecio");
                        FileUpload fuImagen =  (FileUpload)gvMenu.Rows[i].FindControl("fuImagen");

                        nombre_menu = txtNombre.Text.Trim();
                        descripcion_menu = txtDescripcion.Text.Trim();
                        precio_menu = Convert.ToDouble(txtPrecio.Text.Trim());
                        Codigo_comedor = Convert.ToInt32(ddlComedor.SelectedValue.ToString());
                        Codigo_categoria = Convert.ToInt32(ddlCategoria.SelectedValue.ToString());
                        tamanio_imagen = fuImagen.PostedFile.ContentLength;
                        imagen_original = new byte[tamanio_imagen];
                        fuImagen.PostedFile.InputStream.Read(imagen_original, 0, tamanio_imagen);
                        //Bitmap imagen_binaria = null;
                        /*if (tamanio_imagen > 0)
                        {
                            imagen_binaria = new Bitmap(fuImagen.PostedFile.InputStream);
                        }*/
                        Bitmap imagen_binaria = new Bitmap(fuImagen.PostedFile.InputStream);
                        //Crear una imagen Thumbnail
                        System.Drawing.Image imgThumbnail;
                        int tamanioThumbnail = 200;
                        imgThumbnail = RedimensionarImagen(imagen_binaria, tamanioThumbnail);
                        byte[] bImagenThumbnail = new byte[tamanioThumbnail];
                        ImageConverter convertidor = new ImageConverter();
                        bImagenThumbnail = (byte[])convertidor.ConvertTo(imgThumbnail, typeof(byte[]));

                        //Creo los parametros que se le enviaran al procedimiento almacenando.
                        SqlParameter pOpcion = new SqlParameter("@opcion", SqlDbType.SmallInt);
                        pOpcion.Value = 1;
                        SqlParameter pNombre = new SqlParameter("@nombre_menu", SqlDbType.VarChar);
                        pNombre.Value = nombre_menu;
                        SqlParameter pDescripcion = new SqlParameter("@descripcion_menu", SqlDbType.VarChar);
                        pDescripcion.Value = descripcion_menu;
                        SqlParameter pImagenMenu = new SqlParameter("@imagen_menu", SqlDbType.Image);
                        pImagenMenu.Value = bImagenThumbnail;//imagen_original;
                        SqlParameter pPrecio = new SqlParameter("@precio_menu", SqlDbType.Money);
                        pPrecio.Value = precio_menu;
                        SqlParameter pIdCategoria = new SqlParameter("@id_categoria", SqlDbType.SmallInt);
                        pIdCategoria.Value = Codigo_categoria;
                        SqlParameter pIdComedor = new SqlParameter("@id_comedor", SqlDbType.Int);
                        pIdComedor.Value = Codigo_comedor;
                        SqlParameter pMensaje = new SqlParameter("@mensaje", SqlDbType.VarChar, 50);

                        //Agrego los parametros al sqlcommand
                        SqlCommand cmd = new SqlCommand();
                        cmd.Parameters.Add(pOpcion);
                        cmd.Parameters.Add(pNombre);
                        cmd.Parameters.Add(pDescripcion);
                        cmd.Parameters.Add(pImagenMenu);
                        cmd.Parameters.Add(pPrecio);
                        cmd.Parameters.Add(pIdCategoria);
                        cmd.Parameters.Add(pIdComedor);
                        cmd.Parameters.Add(pMensaje).Direction = ParameterDirection.Output;
                        SqlConnection conexion = new SqlConnection(conn.CadenaConexionBD());
                        conexion.Open();
                        cmd.Connection = conexion;
                        cmd.CommandText = "dbo.sp_crear_menu_gastronomico";
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.ExecuteNonQuery();
                        mensaje = cmd.Parameters["@mensaje"].Value.ToString();
                        conexion.Close();
                    }
                }
            }
            catch(Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }

        protected void ddlCategoria_SelectedIndexChanged(object sender, EventArgs e)
        {
            String nombre_categoria = "";
            nombre_categoria = ddlCategoria.SelectedItem.Text;
            Codigo_categoria = Convert.ToInt32(ddlCategoria.SelectedValue.ToString());
            lblInstrucciones.Text = "";

            if (codigo_categoria > 0)
            {
                divCargaMenu.Visible = true;
                lblInstrucciones.Text = "Agregue la cantidad de menús para la categoria " + nombre_categoria;
            }
        }

        protected void ddlComedor_SelectedIndexChanged(object sender, EventArgs e)
        {
            Codigo_comedor = Convert.ToInt32(ddlComedor.SelectedValue.ToString());
        }
    }
}