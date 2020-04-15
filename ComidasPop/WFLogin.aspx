<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WFLogin.aspx.cs" Inherits="ComidasPop.WFLogin" %>

<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <!-- Bootstrap core CSS-->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Custom fonts for this template-->
    <link href="vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <!-- Page level plugin CSS-->
    <link href="vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet" />
    <!-- Custom styles for this template-->
    <link href="css/sb-admin.css" rel="stylesheet" />

    <title>Login</title>
    <style>
        body {
            position: absolute;
            margin: 0;
            width: 100%;
            height: 100%;
            /*background-color: aquamarine;*/
        }

        form {
            position: relative;
            /*margin:0;*/
            width: 100%;
            height: 100%;
        }

        #divWFLogin {
            margin-left: 0;
            width: 100%;
            height: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Century Gothic';
        }

        #divLogin {
            width: 20%;
            height: 55%;
            font-family: 'Century Gothic';
            /*background-color:antiquewhite;*/
            /*border:solid;*/
            /*border-color:aqua;*/
        }

        #div0 {
            background-image: url("Imagenes/logo.png");
            background-repeat: no-repeat;
            background-position: center;
            background-size: 50%;
            width: 100%;
            height: 30%;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        #div1 {
            text-align: center;
        }

        #Label1 {
            font-size: xx-large;
            font-weight: bold;
            font-family: 'Century Gothic';
        }

        .label {
            font-size: larger;
        }

        .txt {
            width: 100%;
            font-family: 'Century Gothic';
            color: aqua;
            font-size: 16px;
        }

        tr {
            width: 100%;
        }

        td {
            width: 100%;
        }

        #tdBoton {
            text-align: center;
        }

        #button {
            width: 250px;
            height: 50px;
        }
    </style>
    <!-- JQUERY -->
    <%--<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.1/jquery-ui.min.js"></script>
    <!-- ALERT -->
    <link href="alert/css/alert.css" rel="stylesheet" />
    <link href="alert/themes/dark/theme.css" rel="stylesheet" />
    <script src="alert/js/alert.js"></script>
    <script type="text/javascript">
        function DialogoWarning(mensaje) {
            $.alert.open('warning', mensaje);
            return false;
        }
    </script>

    <script type="text/javascript">
        function DialogoError(mensaje) {
            $.alert.open('error', mensaje);
            return false;
        }
    </script>

    <script type="text/javascript">
        function DialogoInfo(mensaje) {
            $.alert.open('info', mensaje);
            return false;
        }
    </script>

    <script type="text/javascript">
        function DialogoOption(mensaje) {
            $.alert.open('confirm', mensaje, function (button) {
                if (button == 'yes')
                    //window.location.href = "../WFLogin.aspx";
                    //window.location.href = "../POSWeb/Frm_ImpresionRecibo.aspx";
                    //$.alert.open('You pressed the "yes" button.');
                else if (button == 'no')
                    //$.alert.open('You pressed the "no" button.');
                    return false;
            });
        }
    </script>--%>
    <link href="css/sweetalert.css" rel="stylesheet" />
    <script src="js/sweetalert.min.js" type="text/javascript"></script>
    <link rel="SHORTCUT ICON" href="Imagenes/logo.png"/>
</head>
<body>
    <form id="form1" runat="server">
        <div id="divWFLogin">
            <div id="divLogin">
                <div id="div0">
                </div>
                <div id="div1">
                    <asp:Label ID="Label1" runat="server" Text="Bienvenido"></asp:Label><br />
                    <asp:Label ID="Label2" runat="server" Text="Inicia sesión en Starving o "></asp:Label>
                    <a href="WFRegistro.aspx">crea una cuenta</a>
                </div>
                <br />
                <br />
                <div id="div2">
                    <table style="width: 100%;">
                        <tr>
                            <td>
                                <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="Correo electrónico" CssClass="label"></dx:ASPxLabel>
                                <br />
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <dx:ASPxTextBox ID="ASPxTextBox2" CssClass="txt" runat="server" Width="100%" Border-BorderStyle="None" BorderBottom-BorderStyle="Solid" BorderBottom-BorderColor="#999999" ForeColor="#999999"></dx:ASPxTextBox>
                                <br />
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Contraseña" CssClass="label"></dx:ASPxLabel>
                                <br />
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <dx:ASPxTextBox ID="ASPxTextBox1" CssClass="txt" runat="server" Width="100%" Border-BorderStyle="None" BorderBottom-BorderStyle="Solid" BorderBottom-BorderColor="#999999" ForeColor="#999999" Password="True">
                                    <Border BorderStyle="None"></Border>

                                    <BorderBottom BorderColor="#999999" BorderStyle="Solid"></BorderBottom>
                                </dx:ASPxTextBox>
                                <br />
                                <br />
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td id="tdBoton">
                                <dx:ASPxButton ID="button" runat="server" Text="Iniciar sesión" Theme="MetropolisBlue" Font-Bold="True" Font-Size="Large"></dx:ASPxButton>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
