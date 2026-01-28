<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registro.aspx.cs" Inherits="VerduleriaWeb.Registro" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Crear Cuenta - Verdulería Salvador</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <style>
        body { margin: 0; padding: 0; font-family: 'Segoe UI', sans-serif; }
        
        .fondo-verde {
            background: linear-gradient(135deg, #2e7d32 0%, #81c784 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .tarjeta-registro {
            background-color: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.3);
            width: 100%;
            max-width: 500px; /* Un poco más ancho que el login */
        }

        .titulo { color: #1b5e20; font-weight: bold; text-align: center; margin-bottom: 20px; }

        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; font-weight: 500; margin-bottom: 5px; color: #333; }
        
        .input-custom {
            width: 100%; padding: 10px;
            border: 1px solid #ccc; border-radius: 5px;
            box-sizing: border-box;
        }

        .btn-registrar {
            background-color: #2e7d32; color: white;
            font-weight: bold; border: none; padding: 12px;
            width: 100%; border-radius: 5px; margin-top: 10px;
            font-size: 1rem; cursor: pointer;
            transition: background 0.3s;
        }
        .btn-registrar:hover { background-color: #1b5e20; }
        
        .link-volver {
            display: block; text-align: center; margin-top: 15px;
            color: #666; text-decoration: none;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="fondo-verde">
            <div class="tarjeta-registro">
                <h2 class="titulo">Crear mi Cuenta 📝</h2>
                
                <div class="form-group">
                    <label>Email (Será tu usuario)</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="input-custom" TextMode="Email" required></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Contraseña</label>
                    <asp:TextBox ID="txtPass" runat="server" CssClass="input-custom" TextMode="Password" required></asp:TextBox>
                </div>

                <div style="display: flex; gap: 10px;">
                    <div class="form-group" style="width: 50%;">
                        <label>Nombre</label>
                        <asp:TextBox ID="txtNombre" runat="server" CssClass="input-custom" required></asp:TextBox>
                    </div>
                    <div class="form-group" style="width: 50%;">
                        <label>Apellido</label>
                        <asp:TextBox ID="txtApellido" runat="server" CssClass="input-custom" required></asp:TextBox>
                    </div>
                </div>

                <div class="form-group">
                    <label>Teléfono (Para coordinar)</label>
                    <asp:TextBox ID="txtTelefono" runat="server" CssClass="input-custom"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Dirección de Entrega</label>
                    <asp:TextBox ID="txtDireccion" runat="server" CssClass="input-custom"></asp:TextBox>
                </div>

                <asp:Button ID="btnRegistrar" runat="server" Text="CREAR CUENTA" CssClass="btn-registrar" OnClick="btnRegistrar_Click" />
                
                <a href="Login.aspx" class="link-volver">⬅ Volver al Login</a>

                <asp:Label ID="lblMensaje" runat="server" Text="" ForeColor="Red" Visible="false" style="display:block; text-align:center; margin-top:10px;"></asp:Label>
            </div>
        </div>
    </form>
</body>
</html>
