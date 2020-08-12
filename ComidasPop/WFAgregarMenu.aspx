<%@ Page Title="" Language="C#" MasterPageFile="~/MPPlantilla.Master" AutoEventWireup="true" CodeBehind="WFAgregarMenu.aspx.cs" Inherits="ComidasPop.WFAgregarMenu" %>
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
        #divI{
            position:relative;
            float:left;
            width:50%;
            height:100%;
            background-color:antiquewhite;
        }
        #divID{
            position:relative;
            float:right;
            width:50%;
            height:100%;
            background-color:black;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap-theme.min.css" />
    <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="https://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>

    <div id="divAgregarMenu">
        <div id="divTitulo">
            <asp:Label ID="Label1" runat="server" Text="Menú Gastronomico"></asp:Label>
        </div>
        <div id="divI">
            hola
        </div>
        <div id="divD">
            hola
        </div>
    </div>
</asp:Content>
