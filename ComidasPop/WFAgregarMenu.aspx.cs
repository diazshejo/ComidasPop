#pragma warning disable CS0234 // El tipo o el nombre del espacio de nombres 'ClipboardSource' no existe en el espacio de nombres 'DevExpress' (¿falta alguna referencia de ensamblado?)
using DevExpress.ClipboardSource.SpreadsheetML;
#pragma warning restore CS0234 // El tipo o el nombre del espacio de nombres 'ClipboardSource' no existe en el espacio de nombres 'DevExpress' (¿falta alguna referencia de ensamblado?)
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text.RegularExpressions;
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
                btnGuardar.Visible = false;
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
                    btnGuardar.Visible = true;
                    seCantidad.Value = 1;
                    Session["sDtMenu"] = dtAuxiliar;
                    gvMenu.DataSource = (DataTable)Session["sDtMenu"];
                    gvMenu.DataBind();
                }
            }
#pragma warning disable CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            catch(Exception ex)
#pragma warning restore CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            {

            }
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

        public String ValidarPrecio()
        {
            Regex rgx = new Regex("^[0-9]+.?[0-9]*");   //expresion regular para valores numericos con punto decimal
            String mensaje = "";
            String precio = "";
            int total_filas = 0;

            try
            {
                total_filas = ((DataTable)Session["sDtMenu"]).Rows.Count;

                if (total_filas > 0)
                {
                    for(int i = 0; i < total_filas; i++)
                    {
                        TextBox txtPrecio = (TextBox)gvMenu.Rows[i].FindControl("txtPrecio");
                        precio = txtPrecio.Text.Trim();

                        if(rgx.IsMatch(precio))
                        {
                            mensaje = "OK";
                        }
                        else
                        {
                            mensaje = "ERROR";
                            break;
                        }
                    }
                }
            }
#pragma warning disable CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            catch(Exception ex)
#pragma warning restore CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            {

            }

            return mensaje;
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            int total_registros = 0;
            String nombre_menu = "";
            String descripcion_menu = "";
            Double precio_menu = 0;
            int dia = 0;
            int tamanio_imagen = 0;
            byte[] imagen_original = null;

            total_registros = ((DataTable)Session["sDtMenu"]).Rows.Count;

            try
            {
                if (ValidarPrecio().Equals("OK"))   //valido que los campos de precio que tenga el gridview sean validos.
                {
                    if (((DataTable)Session["sDtMenu"]).Rows.Count > 0)
                    {
                        //recorro los controles del gridview y obtengo los valores que le ingrese
                        for (int i = 0; i < ((DataTable)Session["sDtMenu"]).Rows.Count; i++)
                        {
                            TextBox txtNombre = (TextBox)gvMenu.Rows[i].FindControl("txtNombre");
                            TextBox txtDescripcion = (TextBox)gvMenu.Rows[i].FindControl("txtDescripcion");
                            TextBox txtPrecio = (TextBox)gvMenu.Rows[i].FindControl("txtPrecio");
                            DropDownList ddlDias = (DropDownList)gvMenu.Rows[i].FindControl("ddlDias");
                            FileUpload fuImagen = (FileUpload)gvMenu.Rows[i].FindControl("fuImagen");

                            nombre_menu = txtNombre.Text.Trim();
                            descripcion_menu = txtDescripcion.Text.Trim();
                            precio_menu = Convert.ToDouble(txtPrecio.Text.Trim());
                            Codigo_comedor = Convert.ToInt32(ddlComedor.SelectedValue.ToString());
                            Codigo_categoria = Convert.ToInt32(ddlCategoria.SelectedValue.ToString());
                            dia = Convert.ToInt16(ddlDias.SelectedValue.ToString());
                            //tratamiento de la imagen que se captura en el uploadfile
                            tamanio_imagen = fuImagen.PostedFile.ContentLength;
                            imagen_original = new byte[tamanio_imagen];
                            fuImagen.PostedFile.InputStream.Read(imagen_original, 0, tamanio_imagen);
                            Bitmap imagen_binaria = new Bitmap(fuImagen.PostedFile.InputStream);
                            //Crear una imagen Thumbnail, esto para redimensionar la imagen
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
                            SqlParameter pCalendario = new SqlParameter("@id_calendario", SqlDbType.SmallInt);
                            pCalendario.Value = dia;
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
                            cmd.Parameters.Add(pCalendario);
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
                        ClientScript.RegisterStartupScript(this.GetType(), "Mensaje", "<script> swal({ " +
                                                                                                  " title: 'Mensaje', " +
                                                                                                  " text: 'Se ha agregado el menú con éxito', " +
                                                                                                  " type: 'success', " +
                                                                                                  " confirmButtonText: 'Ok', " +
                                                                                                  " closeOnConfirm: false " +
                                                                                                " }, " +
                                                                                                " function(){ " +
                                                                                                "   window.location.href = 'WFAgregarMenu.aspx';" +       //con esto me redirecciono a la pagina de login
                                                                                                " }); </script>");
                    }
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "mensaje", "<script> swal('Advertencia', 'Ingreso un valor no valido en el precio del producto, revise que el valor del producto sea valido y mayor a 0.', 'warning') </script>");
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
            btnGuardar.Visible = false;
        }
    }
}