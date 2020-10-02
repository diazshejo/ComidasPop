<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WFRegistro.aspx.cs" Inherits="ComidasPop.WFRegistro" %>

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
    <title>Registro</title>
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

        #divWFRegistro {
            margin-left: 0;
            width: 100%;
            height: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family:'Century Gothic';
        }

         #divRegistro {
            width: 20%;
            height: 100%;
            font-family:'Century Gothic';
/*            background-color:antiquewhite;*/
            /*border:solid;*/
            /*border-color:aqua;*/
        }

        #div0 {
            background-image: url("Imagenes/logo.png");
            background-repeat: no-repeat;
            background-position:bottom;
            background-size: 50%;
            width: 100%;
            height:30%;
            display: flex;
            justify-content: center;
            align-items: center;
/*            background-color:antiquewhite;*/
        }
        #div1{
            text-align: center;
            width: 100%;
        }
        #Label1{
            font-size:xx-large;
            font-weight:bold;
            font-family:'Century Gothic';
        }
        .label{
            font-size:larger;
        }
        .txt{
            width:100%;
            font-family:'Century Gothic';
            color:aqua;
            font-size: 16px;
        }
        tr{
            width:100%;
        }
        td{
            width:100%;
        }
        #tdBoton{
            text-align:center;
        }
        #btnCrearCuenta{
            width: 250px;
            height: 50px;
        }
    </style>

    <link href="css/sweetalert.css" rel="stylesheet" />
    <script src="js/sweetalert.min.js" type="text/javascript"></script>
    <link rel="SHORTCUT ICON" href="Imagenes/logo.png"/>
</head>
<body>
    <form id="form1" runat="server">
        <div id="divWFRegistro">
            <div id="divRegistro">
                <div id="div0">
                </div>
                <div id="div1">
                    <asp:Label ID="Label1" runat="server" Text="Abrir una cuenta"></asp:Label><br />
                    <asp:Label ID="Label2" runat="server" Text="Cree una cuenta y obtenga una susbcripción de 30 días grátis para su negocio. "></asp:Label>
                </div>
                <br />
                <div id="div2">
                    <table style="width: 100%;">
                        <tr>
                            <td>
                                <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="Nombres" CssClass="label"></dx:ASPxLabel>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <dx:ASPxTextBox ID="txtNombres" CssClass="txt" runat="server" Width="100%" Border-BorderStyle="None" BorderBottom-BorderStyle="Solid" BorderBottom-BorderColor="#999999" ForeColor="#999999" Height="30" Theme="MetropolisBlue"></dx:ASPxTextBox>
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Apellidos" CssClass="label"></dx:ASPxLabel>
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <dx:ASPxTextBox ID="txtApellidos" CssClass="txt" runat="server" Width="100%" Border-BorderStyle="None" BorderBottom-BorderStyle="Solid" BorderBottom-BorderColor="#999999" ForeColor="#999999" Password="False" Height="30">
                                    <Border BorderStyle="None"></Border>

                                    <BorderBottom BorderColor="#999999" BorderStyle="Solid"></BorderBottom>
                                </dx:ASPxTextBox>
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="Correo electrónico" CssClass="label"></dx:ASPxLabel>
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <dx:ASPxTextBox ID="txtEmail" CssClass="txt" runat="server" Width="100%" Border-BorderStyle="None" BorderBottom-BorderStyle="Solid" BorderBottom-BorderColor="#999999" ForeColor="#999999" Password="False" Height="30">
                                    <Border BorderStyle="None"></Border>

                                    <BorderBottom BorderColor="#999999" BorderStyle="Solid"></BorderBottom>
                                </dx:ASPxTextBox>
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="Contraseña" CssClass="label"></dx:ASPxLabel>
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <dx:ASPxTextBox ID="txtPassword" CssClass="txt" runat="server" Width="100%" Border-BorderStyle="None" BorderBottom-BorderStyle="Solid" BorderBottom-BorderColor="#999999" ForeColor="#999999" Password="True" Height="30">
                                    <Border BorderStyle="None"></Border>

                                    <BorderBottom BorderColor="#999999" BorderStyle="Solid"></BorderBottom>
                                </dx:ASPxTextBox>
                                <br />
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td id="tdBoton">
                                <dx:ASPxButton ID="btnCrearCuenta" runat="server" Text="Crear cuenta" Theme="MetropolisBlue" Font-Bold="True" Font-Size="Large" OnClick="btnCrearCuenta_Click"></dx:ASPxButton>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
