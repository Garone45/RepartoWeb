<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MisPedidos.aspx.cs" Inherits="VerduleriaWeb.MisPedidos" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Mis Pedidos - Verdulería Salvador</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
    <style>
        /* ====================
           ESTILOS BASE (PREMIUM)
           ==================== */
        body { 
            font-family: 'Segoe UI', sans-serif; 
            background-color: #f4f7f6; /* Gris muy clarito de fondo */
            margin: 0; padding: 20px; 
        }

        .contenedor { 
            max-width: 600px; /* Más angosto para que parezca app */
            margin: 0 auto; 
        }

        /* Título y Header */
        .header-top {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .btn-volver { 
            text-decoration: none; color: #555; font-size: 1.2rem; margin-right: 15px; 
            transition: transform 0.2s;
        }
        .btn-volver:active { transform: scale(0.9); }

        h2 { 
            color: #2e7d32; margin: 0; font-size: 1.5rem; letter-spacing: -0.5px;
        }

        /* ====================
           TARJETAS DE PEDIDOS
           ==================== */
        /* Ocultamos los encabezados de tabla en general (el diseño es card-first) */
        .tabla-pedidos { width: 100%; border-collapse: separate; border-spacing: 0 15px; }
        .tabla-pedidos thead { display: none; } /* Chau cabecera verde fea */
        
        .tabla-pedidos tr {
            background-color: white;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05); /* Sombra suave */
            border-radius: 15px; /* Bordes bien redondos */
            display: block; /* Comportamiento de bloque/tarjeta */
            padding: 20px;
            margin-bottom: 20px;
            position: relative;
            transition: transform 0.2s;
        }

        .tabla-pedidos tr:active { transform: scale(0.98); }

        /* Estructura interna de la tarjeta usando Flexbox y Grid */
        .tabla-pedidos td {
            display: block; border: none; padding: 0;
        }

        /* 1. Cabecera de la tarjeta (# Pedido y Fecha) */
        .fila-header {
            display: flex; justify-content: space-between; align-items: center;
            margin-bottom: 10px; border-bottom: 1px dashed #eee; padding-bottom: 10px;
        }
        
        .nro-pedido {
            background-color: #e8f5e9; color: #2e7d32;
            padding: 4px 10px; border-radius: 20px;
            font-size: 0.8rem; font-weight: 800; text-transform: uppercase;
        }

        .fecha-pedido { font-size: 0.9rem; color: #888; }

        /* 2. Cuerpo de la tarjeta (Precio) */
        .fila-precio {
            text-align: center; margin: 15px 0;
        }

        .precio-grande {
            font-size: 2rem; font-weight: 800; color: #333;
            letter-spacing: -1px;
        }
        
        .lbl-total { font-size: 0.8rem; color: #aaa; text-transform: uppercase; letter-spacing: 1px; }

        /* 3. Botón de acción */
        .btn-ver-detalle {
            display: block; width: 100%; text-align: center;
            padding: 12px; border-radius: 12px;
            border: 2px solid #2e7d32; color: #2e7d32; /* Estilo Outline */
            background: transparent; font-weight: bold; text-decoration: none;
            cursor: pointer; transition: all 0.2s;
        }
        
        .btn-ver-detalle:hover {
            background-color: #2e7d32; color: white;
        }

        /* ====================
           MODAL (VENTANA)
           ==================== */
        .modal-overlay {
            position: fixed; top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0,0,0,0.6); z-index: 1000;
            display: flex; justify-content: center; align-items: flex-end; /* En celu sale de abajo */
        }
        
        @media (min-width: 600px) { .modal-overlay { align-items: center; } } /* En PC al medio */

        .modal-caja {
            background: white; width: 100%; max-width: 500px;
            border-radius: 20px 20px 0 0; /* Redondeado solo arriba en celu */
            padding: 25px;
            box-shadow: 0 -10px 40px rgba(0,0,0,0.2);
            animation: subir 0.3s ease-out;
            max-height: 80vh; overflow-y: auto;
        }
        
        @media (min-width: 600px) { 
            .modal-caja { border-radius: 20px; margin: 20px; } 
        }

        @keyframes subir { from { transform: translateY(100%); } to { transform: translateY(0); } }

        .modal-titulo { font-size: 1.2rem; color: #2e7d32; font-weight: bold; margin-bottom: 20px; }

        .item-lista {
            display: flex; justify-content: space-between; margin-bottom: 12px;
            font-size: 0.95rem; border-bottom: 1px solid #f9f9f9; padding-bottom: 8px;
        }
        
        .btn-cerrar-modal {
            background: #eee; border: none; padding: 15px; width: 100%;
            border-radius: 12px; font-weight: bold; color: #333; cursor: pointer;
            margin-top: 20px;
        }

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

        <div class="contenedor">
            
            <div class="header-top">
                <a href="Catalogo.aspx" class="btn-volver">⬅</a>
                <h2>Mis Pedidos</h2>
            </div>

            <asp:GridView ID="dgvPedidos" runat="server" CssClass="tabla-pedidos" AutoGenerateColumns="false" 
                EmptyDataText="🛒 Todavía no hiciste pedidos." GridLines="None" 
                OnRowCommand="dgvPedidos_RowCommand">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            
                            <div class="fila-header">
                              <span class="nro-pedido">Ticket #2026-<%# (int)Eval("Id") + 5000 %></span>
                                <span class="fecha-pedido"><%# Eval("Fecha", "{0:dd/MM/yyyy}") %></span>
                            </div>

                            <div class="fila-precio">
                                <div class="lbl-total">Total</div>
                                <div class="precio-grande">$<%# Eval("Total", "{0:0}") %></div>
                            </div>

                            <asp:LinkButton ID="btnVer" runat="server" CssClass="btn-ver-detalle" 
                                CommandName="VerDetalle" CommandArgument='<%# Eval("Id") %>'>
                                👁️ Ver Productos
                            </asp:LinkButton>

                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <asp:UpdatePanel ID="upModal" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <asp:Panel ID="pnlModal" runat="server" CssClass="modal-overlay" Visible="false">
                    <div class="modal-caja">
                        
                        <div class="modal-titulo">📝 Detalle #<asp:Label ID="lblIdPedidoModal" runat="server"></asp:Label></div>

                        <div class="lista-items">
                            <asp:Repeater ID="repDetalles" runat="server">
                                <ItemTemplate>
                                    <div class="item-lista">
                                        <span style="color: #444;">
                                            <b><%# Eval("Cantidad") %>x</b> <%# Eval("Producto.Nombre") %>
                                        </span>
                                        <span style="font-weight: bold; color: #2e7d32;">
                                            $<%# Eval("PrecioUnitario") %>
                                        </span>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>

                        <div style="text-align: right; margin-top: 15px; font-size: 1.2rem; font-weight: 800; color: #333;">
                            Total: $<asp:Label ID="lblTotalModal" runat="server"></asp:Label>
                        </div>

                        <asp:LinkButton ID="btnCerrar" runat="server" CssClass="btn-cerrar-modal" OnClick="btnCerrar_Click">Cerrar</asp:LinkButton>
                    </div>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>

    </form>
</body>
</html>