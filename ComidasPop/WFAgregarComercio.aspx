<%@ Page Title="" Language="C#" MasterPageFile="~/MPPlantilla.Master" AutoEventWireup="true" CodeBehind="WFAgregarComercio.aspx.cs" Inherits="ComidasPop.WFAgregarComercio" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%--CSS que se le aplica al formulario--%>
    <style>
        #divAgregarComercio {
            width: 100%;
            height: 100%;
        }

        #divTitulo {
            position: relative;
            float: left;
            width: 100%;
            height: 5%;
            text-align: center;
            font-size: x-large;
            color: #0094ff;
            padding-bottom: 2%;
        }

        #divI {
            position: relative;
            float: left;
            width: 50%;
            height: 95%;
        }

        #divD {
            position: relative;
            float: right;
            width: 50%;
            height: 95%;
        }

        #divI1 {
            position: relative;
            float: left;
            width: 60%;
            height: 70%;
        }

        #divD1 {
            position: relative;
            float: right;
            width: 40%;
            height: 70%;
            text-align: center;
        }

        #divB1 {
            position: relative;
            float: left;
            width: 100%;
            height: 30%;
        }

        imgLogo {
            position: relative;
            height: 75%;
            width: 55%;
        }

        .txt {
            position: relative;
            width: 100%;
            height: 100%;
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
            position: relative;
            width: 100%;
            height: 100%;
        }

        #btnGuardar {
        }

        #txtNombre {
            position: relative;
            width: 5%;
        }

        .pac-container {
            z-index: 99999;
        }
    </style>


</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap-theme.min.css" />
    <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="https://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
    <%--poner aqui la llave de google maps--%>

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
                            <td>
                                <asp:TextBox ID="txtNombre" runat="server" Width="100%" Height="30px" required></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>Telefono:</td>
                            <td>
                                <asp:TextBox ID="txtTelefono" runat="server" Width="100%" Height="30px"></asp:TextBox></td>
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
                            <td>Ubicación:</td>
                            <td>
                                <button id="btnMapa" type="button" data-toggle="modal" data-target="#ModalMap" class="btn btn-default" style="width: 100%" runat="server">
                                    <span class="glyphicon glyphicon-map-marker"></span><span id="ubicacion">Seleccione la ubicacion</span>
                                </button>
                                <asp:CheckBox ID="chkSinUbicacion" runat="server" Text="Sin ubicación" Width="200px" AutoPostBack="True" OnCheckedChanged="chkSinUbicacion_CheckedChanged" />
                            </td>
                        </tr>
                        <tr>
                            <td>Logo:</td>
                            <td>
                                <asp:FileUpload ID="FilePhoto" runat="server" CssClass="fileupload" onchange="readURL(this)" Width="100%" Height="30px" accept="image/png, image/jpeg" /><br />
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <asp:Button ID="btnGuardar" runat="server" Text="Guardar" Width="70%" Height="30px" OnClick="btnGuardar_Click" /></td>
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
                <div id="divDetalle">
                    <asp:GridView ID="gvDatosComercio" runat="server" AutoGenerateColumns="False" HeaderStyle-HorizontalAlign="Center" OnRowCommand="gvDatosComercio_RowCommand" DataKeyNames="com_id,com_nombre,com_telefono,com_estado,com_fecha_alta,com_fecha_baja,com_latitud,com_longitud,pai_id,dep_id,mun_id,pro_id,pai_nombre,dep_nombre,mun_nombre,com_logo" CellPadding="4" ForeColor="#333333" GridLines="None">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:CommandField ButtonType="Image" ShowSelectButton="True" SelectText="Editar" EditImageUrl="~/Imagenes/editar.png" SelectImageUrl="~/Imagenes/editar.png">
                                <ItemStyle Width="40px" HorizontalAlign="Center" VerticalAlign="Middle" />
                            </asp:CommandField>
                            <asp:BoundField DataField="com_id" HeaderText="ID" Visible="False" />
                            <asp:BoundField DataField="pai_nombre" HeaderText="PAIS">
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                <ItemStyle Width="100px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="com_nombre" HeaderText="NOMBRE">
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle Width="200px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="com_telefono" HeaderText="TELEFONO">
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle Width="75px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="com_estado" HeaderText="ESTADO">
                                <HeaderStyle HorizontalAlign="Center" Width="75px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="com_fecha_alta" HeaderText="FECHA DE ALTA">
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="com_fecha_baja" HeaderText="FECHA DE BAJA">
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

        <%--Ventana modal que muestra el mapa en el navegador, en forma de popup--%>
        <div class="modal fade" id="ModalMap" tabindex="-1" role="dialog" style="width: 34%; height: 68%; align-content: center; overflow-y: hidden;">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <%--<div class="modal-body" style="width:800px;">--%>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Ubicacion:</label>
                        <div class="col-sm-9">
                            <asp:TextBox ID="ModalMapaddress" CssClass="form-control" runat="server" Height="40px"></asp:TextBox>
                        </div>
                        <div class="col-sm-1">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Cerrar">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    </div>
                    <div id="ModalMapPreview" style="width: 598px; height: 500px;"></div>
                    <div class="clearfix">&nbsp;</div>

                    <div class="m-t-small">
                        <label class="p-r-small col-sm-1 control-label">Lat.:</label>
                        <div class="col-sm-3">
                            <asp:TextBox ID="txtLatitud" runat="server" Width="110%" Height="30px" CssClass="form-control" Visible="True"></asp:TextBox>
                        </div>
                        <label class="p-r-small col-sm-1 control-label">Long.:</label>
                        <div class="col-sm-3">
                            <asp:TextBox ID="txtLongitud" runat="server" Width="110%" Height="30px" CssClass="form-control" Visible="True"></asp:TextBox>
                        </div>
                        <div class="col-sm-3">
                            <button type="button" class="btn btn-primary btn-block" data-dismiss="modal">Aceptar</button>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <script>
                        navigator.geolocation.watchPosition(function (posicion) {
                            $('#ModalMapPreview').locationpicker({
                                radius: 0,
                                location: {
                                    latitude: posicion.coords.latitude,
                                    longitude: posicion.coords.longitude
                                },
                                enableAutocomplete: true,
                                inputBinding: {
                                    locationNameInput: $('#<%=ModalMapaddress.ClientID%>'),
                                    latitudeInput: $('#<%=txtLatitud.ClientID%>'),
                                    longitudeInput: $('#<%=txtLongitud.ClientID%>')

                                },
                                onchanged: function (currentLocation, radius, isMarkerDropped) {
                                    $('#ubicacion').html($('#<%=ModalMapaddress.ClientID%>').val());
                                }
                            });
                        });

                        $('ModalMap').on('shown.bs.modal', function () {
                            $('#ModalMapPreview').locationpicker('autosize');
                        })
                    </script>
                    <%--</div>--%>
                </div>
            </div>
        </div>

        <div id="divD">
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
