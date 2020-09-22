<%@ Page Title="" Language="C#" MasterPageFile="~/MPPlantilla.Master" AutoEventWireup="true" CodeBehind="WFCatalogoMenu.aspx.cs" Inherits="ComidasPop.WFCatalogoMenu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        #divAgregarMenu {
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

        /*#divDatos {
            position: relative;
            float: left;
            width: 100%;
            height: 20%;
        }*/

        .row {
            position: relative;
            overflow-y: auto;
            float: right;
/*            padding-left: 10px;*/
            width: 100%;
            height: 600px;
        }

        #header5 {
            font-size:small;
            color: #FF9900;
            text-align:center;
        }

        #header6 {
            font-size:small;
            color: #FF9900;
            text-align:center;
        }
        #header7{
            font-size:small;
            color: #0094ff;
            text-align:center;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap-theme.min.css" />
    <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="https://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>

    <div id="divCatalogoMenu">
        <div id="divTitulo">
            <asp:Label ID="Label1" runat="server" Text="Catálogo  de menús"></asp:Label>
        </div>
        <div id="divContenidoCatalogo">
            <div>
                <table>
                    <tr>
                        <td>Comercio:</td>
                        <td>
                            <asp:DropDownList ID="ddlComercio" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlComercio_SelectedIndexChanged"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>Categoría:</td>
                        <td>
                            <asp:DropDownList ID="ddlCategoria" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlCategoria_SelectedIndexChanged"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            
                        </td>
                    </tr>
                </table>
            </div>
            <hr />
            <br />
            <div class="row">
                <asp:Repeater ID="repetidor" runat="server">
                    <ItemTemplate>
                        <div class="col-md-2" style="text-align:center; border-color: #0094ff; border-style: solid; border-width: thin; width: 16%; height: 55%; vertical-align: central;">
                            <h5 id="header5">MENU: <%# DataBinder.Eval(Container.DataItem, "men_nombre") %></h5>
                            <img class="img-responsive" src="data:image/jpg;base64,<%# Convert.ToBase64String((byte[])DataBinder.Eval(Container.DataItem, "men_imagen"))%>" style="height: 35%; width: 100%;" />
                            <h5 id="header6">PRECIO: Q. <%# DataBinder.Eval(Container.DataItem, "men_precio", "{0:0.00}") %></h5>
                            <h5 id="header7">CATEGORIA: <%# DataBinder.Eval(Container.DataItem, "cat_nombre") %></h5>
                            <asp:HyperLink ID="HyperLink2" runat="server" ImageUrl="~/Imagenes/editar.png" ToolTip="Editar producto">HyperLink</asp:HyperLink>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>
</asp:Content>

