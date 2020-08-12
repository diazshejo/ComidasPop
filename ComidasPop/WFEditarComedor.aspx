<%@ Page Title="" Language="C#" MasterPageFile="~/MPPlantilla.Master" AutoEventWireup="true" CodeBehind="WFEditarComedor.aspx.cs" Inherits="ComidasPop.WFEditarComedor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%--CSS que se le aplica al formulario--%>
    <style>
        #divAgregarComercio {
            width: 100%;
            height: 100%;
            /*            background-color:blue;*/
        }

        #divTitulo {
            position: relative;
            float: left;
            width: 100%;
            height: 5%;
            text-align: center;
            font-size: x-large;
            color: #0094ff;
            padding-bottom:2%;
            /*            padding-bottom: 5%;*/
        }

        #divI {
            position: relative;
            float: left;
            width: 50%;
            height: 95%;
            /*            background-color:#ffd800;*/
        }

        #divD {
            position: relative;
            float: right;
            width: 50%;
            height: 95%;
            /*            background-color:#ff0000;*/
        }

        #divI1 {
            position: relative;
            float: left;
            width: 60%;
            height: 70%;
/*            background-color:#808080;*/
        }

        #divD1 {
            position: relative;
            float: right;
            width: 40%;
            height: 70%;
            text-align:center;
/*            background-color:#ffd800;*/
        }

        #divB1 {
            position: relative;
            float: left;
            width: 100%;
            height: 30%;
/*            background-color:aqua;*/
        }

        imgLogo {
            position: relative;
            height: 75%;
            width: 55%;
        }

        .txt {
            position:relative;
            width: 100%;
            height:100%;
            resize: horizontal;
        }

        .cb {
            width: 95%;
        }

        #image_upload_preview {
            border: thin;
        }

        #divTabla {
            position: relative;
            resize: horizontal;
            width: 97%;
        }

        .ll {
            width: 60%;
        }

        #divDetalle {
            position:relative;
            width: 100%;
            height:100%;
        }

        #btnGuardar {
        }

        #txtNombre {
            position: relative;
            width: 5%;
        }

        /*.auto-style2 {
            width: 153px;
        }*/
        /*        Stylo que se usa para el mapa*/
        .pac-container {
            z-index: 99999;
        }

        #ModalMapPreview {
            position: relative;
            width: 100%;
            height: 100%;
        }
        /*.auto-style1 {
            width: 200px;
        }*/
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap-theme.min.css" />
    <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="https://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
    <script type="text/javascript" src='https://maps.google.com/maps/api/js?sensor=false&libraries=places&key=AIzaSyCaK0zaEpHV9mLBWkFYkDk1A_AcZhYcizk'></script>
    <script src="js/locationpicker.jquery.js"></script>

    <div id="divAgregarComercio">
        <div id="divTitulo">
            <asp:Label ID="Label1" runat="server" Text="Establecimiento comercial"></asp:Label>
        </div>
        <div id="divI">
            <div id="divI1">
                <asp:Label ID="Label2" runat="server" Text="Datos del comercio" ForeColor="#FF9900" Font-Size="X-Large"></asp:Label>
                <div id="divTabla">
                    <table>
                        <tr>
                            <td>Nombre comercio:</td>
                            <td><asp:TextBox ID="txtNombre" runat="server" Width="100%" Height="30px" required></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>Telefono:</td>
                            <td><asp:TextBox ID="txtTelefono" runat="server" Width="100%" Height="30px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>Pais:</td>
                            <td>
                                <asp:DropDownList ID="ddlPais" runat="server" Width="100%" required AutoPostBack="True" OnSelectedIndexChanged="ddlPais_SelectedIndexChanged" DataTextField="pai_nombre" DataValueField="pai_id">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>Departamento:</td>
                            <td>
                                <asp:DropDownList ID="ddlDepartamento" runat="server" Width="100%" required AutoPostBack="True" OnSelectedIndexChanged="ddlDepartamento_SelectedIndexChanged">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>Municipio:</td>
                            <td>
                                <asp:DropDownList ID="ddlMunicipio" runat="server" Width="100%" required AutoPostBack="True">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>Latitud:</td>
                            <td><asp:TextBox ID="txtLatitud" runat="server" Width="60%" Height="30px" CssClass="form-control"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>Longitud:</td>
                            <td><asp:TextBox ID="txtLongitud" runat="server" Width="60%" Height="30px" CssClass="form-control"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>Logo:</td>
                            <td><asp:FileUpload ID="FilePhoto" runat="server" CssClass="fileupload" onchange="readURL(this)" Width="100%" /><br /></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td><asp:Button ID="btnGuardar" runat="server" Text="Guardar" Width="70%" Height="30px" OnClick="btnGuardar_Click" /></td>
                        </tr>
                    </table>
                    <br />
                    <br />
                </div>
            </div>
            <div id="divD1">
                <%--<img id="imgLogo" src="Imagenes/placeholder.png" alt="Preview" width="100" height="100" />--%>
                <img id="imgLogo" width="300" height="300" />
            </div>
            <div id="divB1">
                <br />
                <br />
                <br />
                <div id="divDetalle">
                    <asp:GridView ID="gvDatosComercio" runat="server" AutoGenerateColumns="False" HeaderStyle-HorizontalAlign="Center" OnRowCommand="gvDatosComercio_RowCommand" DataKeyNames="com_id,com_nombre,com_telefono,com_estado,com_fecha_alta,com_fecha_baja,com_latitud,com_longitud,pai_id,dep_id,mun_id,pro_id,pai_nombre,dep_nombre,mun_nombre,com_logo" CellPadding="4" ForeColor="#333333" GridLines="None">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:CommandField ButtonType="Image" ShowSelectButton="True" SelectText="Editar" EditImageUrl="~/Imagenes/editar.png" SelectImageUrl="~/Imagenes/editar.png" >
                            <ItemStyle Width="40px" HorizontalAlign="Center" VerticalAlign="Middle" />
                            </asp:CommandField>
                            <asp:BoundField DataField="com_id" HeaderText="ID" Visible="False" />
                            <asp:BoundField DataField="pai_nombre" HeaderText="PAIS" >
                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            <ItemStyle Width="100px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="com_nombre" HeaderText="NOMBRE" >
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle Width="200px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="com_telefono" HeaderText="TELEFONO" >
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle Width="75px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="com_estado" HeaderText="ESTADO" >
                            <HeaderStyle HorizontalAlign="Center" Width="75px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="com_fecha_alta" HeaderText="FECHA DE ALTA" >
                            <HeaderStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="com_fecha_baja" HeaderText="FECHA DE BAJA" >
                            <HeaderStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                        </Columns>

                        <EditRowStyle BackColor="#2461BF" />
                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />

<HeaderStyle HorizontalAlign="Center" BackColor="#507CD1" Font-Bold="True" ForeColor="White"></HeaderStyle>
                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#EFF3FB" />
                        <SelectedRowStyle BackColor="#FF9933" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#F5F7FB" />
                        <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                        <SortedDescendingCellStyle BackColor="#E9EBEF" />
                        <SortedDescendingHeaderStyle BackColor="#4870BE" />
                    </asp:GridView>
                </div>
            </div>
        </div>
        <div id="divD">
            <%--<button type="button" data-toggle="modal" data-target="#ModalMap" class="btn btn-default">
                                    <span class="glyphicon glyphicon-map-marker"></span>
                                    <span id="ubicacion">Seleccionar ubicación</span>
                                </button>--%>
            <br />
            <table style="width: 100%;">
                <tr>
                    <td style="width: 8%;">
                        <label>Ubicacion:</label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:TextBox ID="ModalMapaddress" CssClass="form-control" runat="server"></asp:TextBox></td>
                </tr>
            </table>
            <%--Div que despliega el mapa--%>
            <div id="ModalMapPreview" style="width: 100%; height: 700px;"></div>

            <%--Script para controlar el mapa.--%>
            <script>
                //establezco las coordenas de origen en donde se encuentra el dispositivo
                navigator.geolocation.getCurrentPosition(function (posicion) {
                    $('#ModalMapPreview').locationpicker('location', {
                        latitude: posicion.coords.latitude,
                        longitude: posicion.coords.longitude
                    });
                });

                //navigator.geolocation.getCurrentPosition(function (posicion) {
                //    $('#ModalMapPreview').locationpicker({
                //        location: {
                //            latitude: posicion.coords.latitude,
                //            longitude: posicion.coords.longitude
                //        }
                //    });
                //});

                $('#ModalMapPreview').locationpicker({
                    radius: 100,
                    //location: {
                    //    latitude: 14.520048,
                    //    longitude: -90.570004
                    //},
                    enableAutocomplete: true,
                    inputBinding: {
                        latitudeInput: $('#<%=txtLatitud.ClientID%>'),
                        longitudeInput: $('#<%=txtLongitud.ClientID%>'),
                        locationNameInput: $('#<%=ModalMapaddress.ClientID%>')
                    },
                    onchanged: function (currentLocation, radius, isMarkerDropped) {
                        $('#ubicacion').html($('#<%=ModalMapaddress.ClientID%>').val());
                    }
                });

                $('#ModalMap').on('shown.bs.modal', function () {
                    $('#ModalMapPreview').locationpicker('autosize');
                });
            </script>
        </div>
    </div>

    <%--Script para controlar la imagen previa que muestra el uploadfile--%>
    <script>
        function readURL(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#imgLogo').attr('src', e.target.result);
                }

                reader.readAsDataURL(input.files[0]);
            }
        }
        $("#filePhoto").change(function () {
            readURL(this);
        });
    </script>
</asp:Content>
