<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="VerduleriaWeb.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Ingreso Salvador</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
    <style>
        /* RESET BÁSICO */
        body { margin: 0; padding: 0; font-family: 'Segoe UI', sans-serif; background-color: #2e7d32; }

        /* FONDO */
        .fondo-login {
            background: linear-gradient(135deg, #2e7d32 0%, #1b5e20 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        /* TARJETA BLANCA */
        .tarjeta-login {
            background-color: #ffffff;
            padding: 40px 30px;
            border-radius: 20px; /* Más redondeado */
            box-shadow: 0 15px 35px rgba(0,0,0,0.2); /* Sombra suave y profunda */
            width: 100%;
            max-width: 380px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        
        /* DETALLE DECORATIVO ARRIBA */
        .tarjeta-login::before {
            content: "";
            position: absolute; top: 0; left: 0; width: 100%; height: 6px;
            background: linear-gradient(90deg, #43a047, #66bb6a);
        }

        .titulo-verde {
            color: #1b5e20;
            font-weight: 800;
            margin-bottom: 5px;
            font-size: 1.8rem;
            letter-spacing: -0.5px;
        }

        .subtitulo {
            color: #888;
            font-size: 0.95rem;
            margin-bottom: 30px;
        }

        /* INPUTS MODERNOS */
        .grupo-input {
            text-align: left;
            margin-bottom: 20px;
        }
        
        .label-input {
            font-size: 0.85rem;
            font-weight: 600;
            color: #555;
            margin-bottom: 8px;
            display: block;
            margin-left: 5px;
        }

        .input-custom {
            width: 100%;
            padding: 14px 15px; /* Más alto para el dedo */
            border-radius: 12px;
            border: 2px solid #f0f0f0;
            background-color: #f9f9f9;
            font-size: 1rem;
            box-sizing: border-box;
            transition: all 0.3s ease;
            outline: none;
        }

        .input-custom:focus {
            border-color: #2e7d32;
            background-color: #fff;
            box-shadow: 0 0 0 4px rgba(46, 125, 50, 0.1);
        }

        /* BOTÓN PRINCIPAL */
        .btn-ingresar {
            background: linear-gradient(to right, #2e7d32, #43a047);
            color: white;
            font-weight: bold;
            border: none;
            padding: 15px;
            width: 100%;
            border-radius: 50px; /* Estilo píldora */
            margin-top: 10px;
            font-size: 1.1rem;
            cursor: pointer;
            box-shadow: 0 5px 15px rgba(46, 125, 50, 0.3);
            transition: transform 0.2s;
        }
        .btn-ingresar:active {
            transform: scale(0.98);
        }

        /* LINK SECUNDARIO */
        .contenedor-registro {
            margin-top: 25px;
            padding-top: 20px;
            border-top: 1px solid #f0f0f0;
        }
        
        .btn-registro {
            display: inline-block;
            color: #2e7d32;
            text-decoration: none;
            font-weight: bold;
            border: 2px solid #e8f5e9;
            padding: 10px 20px;
            border-radius: 30px;
            font-size: 0.9rem;
            background: #e8f5e9;
            transition: background 0.3s;
        }
        .btn-registro:hover {
            background-color: #c8e6c9;
        }

        /* MENSAJE ERROR */
        .alerta-error {
            background-color: #ffebee;
            color: #c62828;
            padding: 10px;
            border-radius: 8px;
            font-size: 0.9rem;
            margin-top: 15px;
            border: 1px solid #ffcdd2;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="fondo-login">
            <div class="tarjeta-login">
                
                <h2 class="titulo-verde">Verdulería<br>Salvador 🥦</h2>
                <p class="subtitulo">Ingresá para hacer tu pedido</p>

                <div class="grupo-input">
                    <label class="label-input">Correo Electrónico</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="input-custom" TextMode="Email" placeholder="ej: usuario@gmail.com"></asp:TextBox>
                </div>

                <div class="grupo-input">
                    <label class="label-input">Contraseña</label>
                    <asp:TextBox ID="txtPass" runat="server" CssClass="input-custom" TextMode="Password" placeholder="••••••••"></asp:TextBox>
                </div>

                <asp:Button ID="btnIngresar" runat="server" Text="INGRESAR" CssClass="btn-ingresar" OnClick="btnIngresar_Click" />

                <asp:Panel ID="pnlError" runat="server" Visible="false">
                    <div class="alerta-error">
                        ⚠️ <asp:Label ID="lblError" runat="server" Text="Datos incorrectos"></asp:Label>
                    </div>
                </asp:Panel>

                <div class="contenedor-registro">
                    <p style="margin: 0 0 10px 0; color: #999; font-size: 0.9rem;">¿Es tu primera vez?</p>
                    <a href="Registro.aspx" class="btn-registro">Crear cuenta nueva</a>
                </div>

            </div>
        </div>
    </form>
</body>
</html>