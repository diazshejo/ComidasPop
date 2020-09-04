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

    <div id="divAgregarMenu">
        <div id="divTitulo">
            <asp:Label ID="Label1" runat="server" Text="Menú Gastronomico"></asp:Label>
        </div>
        <asp:Label ID="Label2" runat="server" Text="Datos de comercio y categoría" ForeColor="#FF9900" Font-Size="X-Large"></asp:Label>
        <div id="divDatos">
            <br />
            <table>
                <tr>
                    <td>Comedor:</td>
                    <td>
                        <asp:DropDownList ID="ddlComedor" runat="server" required OnSelectedIndexChanged="ddlComedor_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>Categoría:</td>
                    <td>
                        <asp:DropDownList ID="ddlCategoria" runat="server" required AutoPostBack="True" OnSelectedIndexChanged="ddlCategoria_SelectedIndexChanged"></asp:DropDownList>
                    </td>
                </tr>
            </table>
            <hr />
            <br />
        </div>

        <div id="divCargaMenu" runat="server">
            <asp:Label ID="Label3" runat="server" Text="Datos de menú" ForeColor="#FF9900" Font-Size="X-Large"></asp:Label>
            <br />
            <asp:Label ID="lblInstrucciones" runat="server" ForeColor="#0094ff" Font-Size="Larger"></asp:Label>
            <br />
            <br />
            <div id="divFilas">
                <table>
                    <tr>
                        <td>Cantidad:</td>
                        <td>
                            <dx:ASPxSpinEdit ID="seCantidad" runat="server" Number="1" AllowNull="False" Font-Bold="True" HorizontalAlign="Center" Width="150px" NumberType="Integer" MaxValue="25" MaxLength="2" MinValue="1">
                                <ValidationSettings CausesValidation="True" Display="Dynamic" ErrorTextPosition="Bottom">
                                </ValidationSettings>
                            </dx:ASPxSpinEdit>
                        </td>
                        <td>
                            <asp:Button ID="btnAgregarFila" runat="server" Text="Agregar" OnClick="btnAgregarFila_Click" Height="30px" /></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <asp:Button ID="btnGuardar" runat="server" Text="Guardar" OnClick="btnGuardar_Click" Width="70%" Height="30px" /></td>
                        <td></td>
                </table>
                <hr />
            </div>
            <div id="divGrid">
                <asp:GridView ID="gvMenu" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" Width="100%" DataKeyNames="ID" Height="200px">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:TemplateField HeaderText="Nombre producto">
                            <ItemTemplate>
                                <asp:TextBox ID="txtNombre" runat="server" Width="100%" Height="30px" Text='<%# ((TextBox)Eval("nombre_menu")).Text %>'></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle Width="100px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Descripcion producto">
                            <ItemTemplate>
                                <asp:TextBox ID="txtDescripcion" runat="server" Width="100%" Height="30px" Text='<%# ((TextBox)Eval("descripcion_menu")).Text %>'></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle Width="150px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Precio de producto">
                            <ItemTemplate>
                                <asp:TextBox ID="txtPrecio" runat="server" Width="100%" Height="30px" Text='<%# ((TextBox)Eval("precio_menu")).Text %>'></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle Width="50px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Fotografía">
                            <ItemTemplate>
                                <div id="divArchivo" style="width: 100%;">
                                    <asp:FileUpload ID="fuImagen" runat="server" Height="40px" Width="250px" ValidationExpression="[a-zA-Z0_9].*\b(.jpeg|.JPEG|.jpg|.JPG|.jpe|.JPE|.png|.PNG|.mpp|.MPP|.gif|.GIF)" />
                                </div>
                            </ItemTemplate>
                            <ItemStyle Width="350px" />
                        </asp:TemplateField>
                    </Columns>
                    <EditRowStyle BackColor="#2461BF" />
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EFF3FB" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#F5F7FB" />
                    <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                    <SortedDescendingCellStyle BackColor="#E9EBEF" />
                    <SortedDescendingHeaderStyle BackColor="#4870BE" />
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>
