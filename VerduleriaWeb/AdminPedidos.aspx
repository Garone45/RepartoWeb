<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminPedidos.aspx.cs" Inherits="VerduleriaWeb.AdminPedidos" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Control de Pedidos</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; padding: 20px; background-color: #f4f7f6; }
        .contenedor { max-width: 1000px; margin: 0 auto; background: white; padding: 20px; border-radius: 10px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); }
        h2 { color: #333; border-bottom: 2px solid #27ae60; padding-bottom: 10px; }
        
        /* Grillas */
        .grilla { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
        .grilla th { background-color: #27ae60; color: white; padding: 12px; text-align: left; }
        .grilla td { border: 1px solid #eee; padding: 10px; color: #555; }
        .grilla tr:hover { background-color: #f9f9f9; }

        /* Grilla de Detalle (más chiquita) */
        .grilla-detalle th { background-color: #2980b9; } /* Azul para diferenciar */
        
        .total-pedido { font-size: 1.2rem; font-weight: bold; color: #27ae60; text-align: right; margin-top: 10px; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="contenedor">
            <a href="AdminProductos.aspx">⬅️ Ir a Productos</a>
            <br /><br />

            <h2>📦 Últimos Pedidos</h2>
            
            <asp:GridView ID="gridPedidos" runat="server" CssClass="grilla" AutoGenerateColumns="False"
                DataKeyNames="Id" 
                OnSelectedIndexChanged="gridPedidos_SelectedIndexChanged">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="# Pedido" />
                    <asp:BoundField DataField="Fecha" HeaderText="Fecha" DataFormatString="{0:dd/MM/yyyy HH:mm}" />
                    <asp:BoundField DataField="Cliente" HeaderText="Cliente" />
                    <asp:BoundField DataField="Direccion" HeaderText="Dirección" />
                    <asp:BoundField DataField="Total" HeaderText="Total ($)" />
                    
                    <asp:CommandField ShowSelectButton="True" SelectText="👁️ Ver Detalle" ControlStyle-Font-Bold="true" />
                </Columns>
            </asp:GridView>

            <br />
            
            <asp:Panel ID="panelDetalle" runat="server" Visible="false" style="background: #eefbff; padding: 15px; border-radius: 10px;">
                <h3 style="margin-top:0; color: #2980b9;">🛒 Detalle del Pedido #<asp:Label ID="lblNroPedido" runat="server"></asp:Label></h3>
                
                <asp:GridView ID="gridDetalles" runat="server" CssClass="grilla grilla-detalle" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="Producto" HeaderText="Producto" />
                        <asp:BoundField DataField="PrecioUnitario" HeaderText="Precio Unit." />
                        <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" />
                        <asp:BoundField DataField="Subtotal" HeaderText="Subtotal" />
                    </Columns>
                </asp:GridView>

                <div class="total-pedido">
                    Total Final: $<asp:Label ID="lblTotalDetalle" runat="server"></asp:Label>
                </div>
            </asp:Panel>

        </div>
    </form>
</body>
</html>