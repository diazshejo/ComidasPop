<%@ Page Title="" Language="C#" MasterPageFile="~/MPPlantilla.Master" AutoEventWireup="true" CodeBehind="WFPrincipal.aspx.cs" Inherits="ComidasPop.WFPrincipal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script>
        window.location.hash = "no-back-button";
        window.location.hash = "Again-No-back-button";//esta linea es necesaria para chrome
        window.onhashchange = function () { window.location.hash = "no-back-button"; }
    </script>
</asp:Content> 
