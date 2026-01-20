<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminProductos.aspx.cs" Inherits="VerduleriaWeb.AdminProductos" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Administrar Productos</title>
    <style>
        body { font-family: sans-serif; padding: 20px; }
        .contenedor { display: flex; gap: 20px; }
        .formulario { border: 1px solid #ccc; padding: 20px; border-radius: 5px; width: 300px; }
        .grilla { width: 100%; border-collapse: collapse; }
        .grilla th { background-color: #4CAF50; color: white; padding: 10px; }
        .grilla td { border: 1px solid #ddd; padding: 8px; }
        label { display: block; margin-top: 10px; font-weight: bold; }
        .btn { background-color: #4CAF50; color: white; padding: 10px; border: none; cursor: pointer; width: 100%; margin-top: 15px; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h1>Gestión de Productos</h1>
        
        <div class="contenedor">
            <div class="formulario">
                <h3>Nuevo Producto</h3>
                
                <label>Nombre:</label>
                <asp:TextBox ID="txtNombre" runat="server" Width="100%"></asp:TextBox>
                
                <label>Categoría:</label>
                <asp:DropDownList ID="ddlCategoria" runat="server" Width="100%"></asp:DropDownList>
                
                <label>Precio (Entero):</label>
                <asp:TextBox ID="txtPrecio" runat="server" TextMode="Number" Width="100%"></asp:TextBox>
                
                <label>Unidad (Ej: Kg, Bolsa):</label>
                <asp:TextBox ID="txtUnidad" runat="server" Width="100%"></asp:TextBox>
                
                <label>Descripción (Opcional):</label>
                <asp:TextBox ID="txtDescripcion" runat="server" TextMode="MultiLine" Width="100%"></asp:TextBox>
                
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar Producto" CssClass="btn" OnClick="btnGuardar_Click" />
                
                <br /><br />
                <asp:Label ID="lblMensaje" runat="server" Text=""></asp:Label>
            </div>

            <div style="flex-grow: 1;">
                <h3>Listado Actual</h3>
                <asp:GridView ID="dgvProductos" runat="server" CssClass="grilla" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="Nombre" HeaderText="Producto" />
                        <asp:BoundField DataField="Precio" HeaderText="Precio ($)" />
                        <asp:BoundField DataField="Unidad" HeaderText="Unidad" />
                        
                        <%-- TRUCO: Para mostrar la propiedad de un objeto dentro de otro --%>
                        <asp:BoundField DataField="Categoria.Nombre" HeaderText="Categoría" />
                        
                        <asp:CheckBoxField DataField="Activo" HeaderText="Activo" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </form>
</body>
</html>
