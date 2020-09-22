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
        </div>

        <div id="divCargaMenu" runat="server">
            <asp:Label ID="Label3" runat="server" Text="Datos de menú" ForeColor="#FF9900" Font-Size="X-Large"></asp:Label>
            <br />
            <asp:Label ID="lblInstrucciones" runat="server" ForeColor="#0094ff" Font-Size="Larger"></asp:Label>
            <br />
            <div id="divFilas">
                <table>
                    <tr>
                        <td>Cantidad:</td>
                        <td>
                            <dx:ASPxSpinEdit ID="seCantidad" runat="server" Number="1" AllowNull="False" Font-Bold="True" HorizontalAlign="Center" Width="150px" NumberType="Integer" MaxValue="25" MaxLength="2" MinValue="1" ToolTip="Escriba la cantidad de producos que ingresara para la categoria seleccionada">
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
                            
                        <td></td>
                </table>
                <hr />
            </div>
            <div id="divGrid">
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar" OnClick="btnGuardar_Click" Width="200px" Height="30px" />
                <br />
                Ingrese la informacion que se le solicita abajo para poder crear los menús.
                <br />
                <asp:GridView ID="gvMenu" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" Width="100%" DataKeyNames="ID" Height="200px" CellSpacing="2" HorizontalAlign="Center" ShowFooter="True">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:BoundField DataField="ID" HeaderText="ID" Visible="False">
                            <ItemStyle Width="10px" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Nombre del producto">
                            <ItemTemplate>
                                <asp:TextBox ID="txtNombre" runat="server" Width="100%" Height="30px" Text='<%# ((TextBox)Eval("nombre_menu")).Text %>' ToolTip="Ingrese el nombre del platillo o menú."></asp:TextBox>
                            </ItemTemplate>
                            <HeaderStyle Font-Bold="True" Font-Size="Medium" />
                            <ItemStyle Width="100px" HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Descripcion del producto">
                            <ItemTemplate>
                                <asp:TextBox ID="txtDescripcion" runat="server" Width="100%" Height="30px" Text='<%# ((TextBox)Eval("descripcion_menu")).Text %>' ToolTip="Ingrese una descripcion para el menú"></asp:TextBox>
                            </ItemTemplate>
                            <HeaderStyle Font-Bold="True" Font-Size="Medium" />
                            <ItemStyle Width="150px" HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Precio del producto">
                            <ItemTemplate>
                                <asp:TextBox ClientIDMode="Static" ID="txtPrecio" runat="server" Width="100%" Height="30px" Text='<%# ((TextBox)Eval("precio_menu")).Text %>' ToolTip="Ingrese el precio del menú." Style="text-align:right;" onblur="validarPrecio(this);" CausesValidation="true"></asp:TextBox>
                            </ItemTemplate>
                            <HeaderStyle Font-Bold="True" Font-Size="Medium" HorizontalAlign="Center" />
                            <ItemStyle Width="60px" HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Dias de publicación">
                            <ItemTemplate>
                                <asp:DropDownList ID="ddlDias" runat="server" DataSourceID="sqlDSComidasPop" DataTextField="cal_dia" DataValueField="cal_id" ToolTip="Seleccione como desea repetir la publicación del menú." Width="100%" CausesValidation="True">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="sqlDSComidasPop" runat="server" ConnectionString="<%$ ConnectionStrings:comidasPopConexionString %>" SelectCommand="sp_obtener_dias_semana" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="1" Name="opcion" Type="Int16" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </ItemTemplate>
                            <HeaderStyle Font-Bold="True" Font-Size="Medium" Width="25px" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="75px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Fotografía del producto">
                            <ItemTemplate>
                                <div id="divArchivo" style="width: 100%;">
                                    <asp:FileUpload ID="fuImagen" runat="server" Height="40px" Width="100%" accept=".png,.jpg,.jpeg,.gif" ToolTip="Seleccione la imagen del menu" ForeColor="#CC3300" Font-Size="Large" />
                                </div>
                            </ItemTemplate>
                            <HeaderStyle Font-Bold="True" Font-Size="Medium" />
                            <ItemStyle Width="350px" VerticalAlign="Middle" />
                        </asp:TemplateField>
                    </Columns>
                    <EditRowStyle BackColor="#999999" />
                    <FooterStyle BackColor="#FF9900" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#FF9900" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" VerticalAlign="Top" />
                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="White" BorderColor="#CCCCCC" ForeColor="#333333" HorizontalAlign="Center" VerticalAlign="Bottom" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                </asp:GridView>
            </div>
        </div>
    </div>
    <script>
        function validarPrecio(el) {
            var ex = /^[0-9]+\.?[0-9]*$/;
            if (ex.test(el.value) == false) {
                swal('Advertencia', 'El valor que esta ingresando en el campo "Precio del producto" es incorrecto.', 'warning');
            }
        }
    </script>
</asp:Content>
