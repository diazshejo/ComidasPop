<%@ Page Title="" Language="C#" MasterPageFile="~/MPPlantilla.Master" AutoEventWireup="true" CodeBehind="WFAgregarComercio.aspx.cs" Inherits="ComidasPop.WFAgregarComercio" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%--Script para validar los campos del formulario--%>
    <script>
        function validar_campo() {

        }
    </script>
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
            padding-bottom: 5%;
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
            width: 50%;
            height: 50%;
        }

        #divD1 {
            position: relative;
            float: right;
            width: 50%;
            height: 50%;
        }

        #divB1 {
            position: relative;
            float: left;
            width: 100%;
            height: 50%;
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
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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
                                <asp:TextBox ID="txtLatitud" runat="server" Width="50%">-18.26</asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style2">Longitud:</td>
                            <td>
                                <asp:TextBox ID="txtLongitud" runat="server" Width="50%">18.25</asp:TextBox>
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
                </div>
            </div>
        </div>
        <div id="divD">
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
