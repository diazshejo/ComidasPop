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

        #divDatos {
            position: relative;
            float: left;
            width: 100%;
            height: 20%;
        }

        #divGrid {
            position: relative;
            overflow-y: auto;
            float: left;
            width: 100%;
            height: 425px;
            /*border-top-style: solid;
            border-top-color: blue;*/
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
            <asp:Label ID="Label1" runat="server" Text="Catalogo  de menús"></asp:Label>
        </div>
        <div class="row">
            <asp:Repeater ID="repetidor" runat="server">
                <ItemTemplate>
                    <div class="col-md-4">
                        <img class="img-responsive" src="data:image/jpg;base64,<%# Convert.ToBase64String((byte[])DataBinder.Eval(Container.DataItem, "men_imagen"))%>" />
                        <%# DataBinder.Eval(Container.DataItem, "men_nombre") %>
                        <br />
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>
