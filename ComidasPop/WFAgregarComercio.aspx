<%@ Page Title="" Language="C#" MasterPageFile="~/MPPlantilla.Master" AutoEventWireup="true" CodeBehind="WFAgregarComercio.aspx.cs" Inherits="ComidasPop.WFAgregarComercio" %>

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
            width: 50%;
            height: 50%;
            /*            background-color:#808080;*/
        }

        #divD1 {
            position: relative;
            float: right;
            width: 50%;
            height: 50%;
            /*            background-color:bisque;*/
        }

        #divB1 {
            position: relative;
            float: left;
            width: 100%;
            height: 50%;
            /*            background-color:aqua;*/
        }

        img {
            position: relative;
            height: 75%;
            width: 55%;
        }

        .txt {
            width: 87%;
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
            width: 100%;
        }

        #btnGuardar {
        }

        #txtNombre {
            position: relative;
            width: 5%;
        }

        .auto-style2 {
            width: 153px;
        }
        /*        Stylo que se usa para el mapa*/
        .pac-container {
            z-index: 99999;
        }

        #ModalMapPreview {
            position: relative;
            width: 100%;
            height: 100%;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">



    <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap-theme.min.css" />
    <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="https://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>

    

    <script src="js/locationpicker.jquery.js"></script>

    <div id="divAgregarComercio">
        <div id="divTitulo">
            <asp:Label ID="Label1" runat="server" Text="Establecimiento comercial"></asp:Label>
        </div>
        <div id="divI">
            <div id="divI1">
                <div id="divTabla">
                    <table>
                        <tr>
                            <td class="auto-style2">Nombre establecimiento:</td>
                            <td>
                                <asp:TextBox ID="txtNombre" runat="server" Width="90%" required></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style2">Telefono:</td>
                            <td>
                                <asp:TextBox ID="txtTelefono" runat="server" Width="90%"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style2">Pais:</td>
                            <td>
                                <asp:DropDownList ID="ddlPais" runat="server" Width="98%" required AutoPostBack="True" OnSelectedIndexChanged="ddlPais_SelectedIndexChanged">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style2">Departamento:</td>
                            <td>
                                <asp:DropDownList ID="ddlDepartamento" runat="server" Width="98%" required AutoPostBack="True" OnSelectedIndexChanged="ddlDepartamento_SelectedIndexChanged">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style2">Municipio:</td>
                            <td>
                                <asp:DropDownList ID="ddlMunicipio" runat="server" Width="98%" required AutoPostBack="True">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style2">Latitud:</td>
                            <td>
                                <asp:TextBox ID="txtLatitud" runat="server" Width="60%" CssClass="form-control"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style2">Longitud:</td>
                            <td>
                                <asp:TextBox ID="txtLongitud" runat="server" Width="60%" CssClass="form-control"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style2"></td>
                            <td>
                                <asp:Button ID="btnGuardar" runat="server" Text="Guardar" Width="70%" OnClick="btnGuardar_Click" />
                            </td>
                        </tr>
                    </table>
                    <br />
                    <br />
                </div>
            </div>
            <div id="divD1">
                <table>
                    <tr>
                        <td>
                            <asp:Label ID="Label2" runat="server" Text="Subir un logo"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:FileUpload ID="FilePhoto" runat="server" CssClass="fileupload" onchange="readURL(this)" /><br />
                        </td>
                    </tr>
                </table>
                <br />
                <img id="imgLogo" src="Imagenes/placeholder.png" alt="Preview" width="100" height="100" />
            </div>
            <div id="divB1">
                <div id="divDetalle">
                    <dx:ASPxGridView ID="ASPxGridView1" runat="server" Theme="SoftOrange"></dx:ASPxGridView>
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
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
                var lat;
                var long;

                function recuperarLocalizacion() {
                    if (navigator.geolocation) {
                        navigator.geolocation.getCurrentPosition(mostrarCoordenada);
                    } else {
                        //alert('El navegador no dispone la capacidad de geolocalización');
                    }
                }


                function mostrarCoordenada(posicion) {
                    lat = posicion.coords.latitude;
                    long = posicion.coords.longitude;
                    //var direccion = posicion.coords.latitude + "," + posicion.coords.longitude;
                    //var mapa = "http://maps.googleapis.com/maps/api/staticmap?center="
                     //   + direccion + "&zoom=14&size=500x500&sensor=false";
                    //document.getElementById("dato").innerHTML = "<img src='" + mapa + "'>";
                }


                $('#ModalMapPreview').locationpicker({
                    radius: 0,
                    location: {
                        latitude: 14.520048,
                        longitude: -90.570004
                        //latitude: lat,
                        //longitude: long
                    },
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
