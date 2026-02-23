<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="VerduleriaWeb.Checkout" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="MiFooter" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Finalizar Pedido - Salvador</title>
     <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;800&display=swap" rel="stylesheet" />
    
    <style>
        /* Navbar del Checkout con botón volver */
        .navbar-checkout { 
            background-color: #2e7d32; 
            padding: 15px 20px; 
            display: flex; 
            justify-content: space-between; /* Separa los elementos a los extremos */
            align-items: center;
            color: white; 
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        
        .navbar-checkout a { color: white; text-decoration: none; }
        
        .titulo-checkout { font-size: 1.3rem; font-weight: 800; }

        .btn-volver {
            display: flex;
            align-items: center;
            gap: 5px;
            font-size: 0.95rem;
            font-weight: 600;
            background: rgba(255,255,255,0.2);
            padding: 6px 12px;
            border-radius: 8px;
            transition: background 0.2s;
        }
        .btn-volver:hover { background: rgba(255,255,255,0.3); }
        body { margin: 0; padding: 0; font-family: 'Poppins', sans-serif; background-color: #f4f7f6; color: #333; }
        
        /* Navbar Simple para no distraer */
        .navbar-checkout { background-color: #2e7d32; padding: 15px 20px; text-align: center; color: white; font-size: 1.5rem; font-weight: 800; }
        .navbar-checkout a { color: white; text-decoration: none; }

        /* Contenedor Principal a 2 Columnas */
        .contenedor-checkout {
            display: flex;
            max-width: 1100px;
            margin: 30px auto;
            gap: 30px;
            padding: 0 20px;
            align-items: flex-start;
        }

        /* Paneles Blancos */
        .panel { background: white; border-radius: 15px; padding: 25px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); }
        .panel h2 { margin-top: 0; color: #2e7d32; border-bottom: 2px solid #eee; padding-bottom: 10px; font-size: 1.4rem; }

        /* COLUMNA IZQUIERDA: Datos del Cliente */
        .col-datos { flex: 3; }
        
        .grupo-form { margin-bottom: 15px; }
        .grupo-form label { display: block; font-size: 0.9rem; font-weight: 600; margin-bottom: 5px; color: #555; }
        .grupo-form input { width: 100%; padding: 12px; border: 1px solid #ccc; border-radius: 8px; font-family: 'Poppins', sans-serif; font-size: 1rem; box-sizing: border-box; }
        .grupo-form input:focus { border-color: #2e7d32; outline: none; box-shadow: 0 0 5px rgba(46,125,50,0.3); }

        /* COLUMNA DERECHA: Resumen del Pedido */
        .col-resumen { flex: 2; position: sticky; top: 20px; }
        
        .item-carrito { display: flex; justify-content: space-between; padding: 10px 0; border-bottom: 1px dashed #eee; font-size: 0.95rem; }
        .item-carrito:last-child { border-bottom: none; }
        
        .total-pedido { display: flex; justify-content: space-between; font-size: 1.4rem; font-weight: 800; color: #2e7d32; margin-top: 20px; padding-top: 20px; border-top: 2px solid #eee; }

        /* Botón de Confirmar */
       .btn-confirmar { 
            width: 100%; 
            background-color: #25d366; /* Verde oficial de WhatsApp */
            color: white; 
            border: none; 
            padding: 18px; /* Un poco más alto para que sea fácil tocar en el celu */
            border-radius: 12px; 
            font-size: 1.3rem; 
            font-weight: 800; 
            cursor: pointer; 
            transition: all 0.3s ease; 
            margin-top: 25px;
            box-shadow: 0 10px 20px rgba(37, 211, 102, 0.2); /* Sombrita verde */
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        .btn-confirmar:hover { 
            background-color: #128c7e; 
            transform: translateY(-3px); 
            box-shadow: 0 15px 30px rgba(37, 211, 102, 0.4); 
        }
        /* Responsive Celular */
        @media (max-width: 800px) {
            .contenedor-checkout { flex-direction: column-reverse; } /* En celu, el carrito queda arriba de los datos */
            .col-datos, .col-resumen { width: 100%; position: static; box-sizing: border-box; }
        }

    </style>

</head>
<body>
    <form id="form1" runat="server">
        
        <div class="navbar-checkout">
            <a href="javascript:history.back()" class="btn-volver">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M19 12H5"></path><polyline points="12 19 5 12 12 5"></polyline></svg>
                Volver
            </a>
            <div class="titulo-checkout">🥦 Salvador</div>
            <div style="width: 80px;"></div> </div>

        <div class="contenedor-checkout">
            
            <div class="panel col-datos">
                <h2>📍 ¿Dónde te lo enviamos?</h2>
                
                <% if (Session["usuario"] == null) { %>
                    <div style="background: #e8f5e9; padding: 15px; border-radius: 8px; margin-bottom: 20px; font-size: 0.9rem;">
                        💡 <b>Compra Rápida:</b> Completá tus datos para este envío. Si ya tenés cuenta, <a href="Login.aspx" style="color: #2e7d32; font-weight: bold;">Ingresá acá</a>.
                    </div>
                <% } %>

                <div class="grupo-form">
                    <label>Nombre y Apellido</label>
                    <input type="text" id="txtNombre" placeholder="Ej: Juan Pérez" required />
                </div>

                <div class="grupo-form">
                    <label>Dirección de Entrega</label>
                    <input type="text" id="txtDireccion" placeholder="Ej: Av. Cabildo 1234, Depto 4B" required />
                </div>

                <div class="grupo-form">
                    <label>Teléfono (WhatsApp)</label>
                    <input type="tel" id="txtTelefono" placeholder="Ej: 1123456789" required />
                </div>

            </div>

            <div class="panel col-resumen">
                <h2>🛒 Tu Pedido</h2>
                
                <div id="listaCheckout">
                    </div>

                <div class="total-pedido">
                    <span>Total:</span>
                    <span id="lblTotalCheckout">$0</span>
                </div>

                <button type="button" class="btn-confirmar" onclick="enviarPedido()">
                    Enviar Pedido por WhatsApp 🚀
                </button>
            </div>

        </div>

        <uc:MiFooter runat="server" />
    </form>

    <script>
        // Cuando carga la página, leemos la memoria
        window.onload = function() {
            let carrito = JSON.parse(localStorage.getItem('miCarrito')) || [];
            let contenedorLista = document.getElementById('listaCheckout');
            let totalPedido = 0;

            if (carrito.length === 0) {
                contenedorLista.innerHTML = "<p style='color:red;'>Tu carrito está vacío.</p>";
                return;
            }

            // Dibujamos cada item
            carrito.forEach(item => {
                contenedorLista.innerHTML += `
                    <div class="item-carrito">
                        <span>${item.nombre}</span>
                        <span>$${item.precio}</span>
                    </div>
                `;
                totalPedido += item.precio;
            });

            // Actualizamos el total
            document.getElementById('lblTotalCheckout').innerText = "$" + totalPedido;
        }

        // Función vacía por ahora, acá armaremos el mensaje de WhatsApp
        function enviarPedido() {
            // 1. Agarramos los datos del formulario
            const nombre = document.getElementById('txtNombre').value;
            const direccion = document.getElementById('txtDireccion').value;
            const telefono = document.getElementById('txtTelefono').value;

            if (!nombre || !direccion || !telefono) {
                alert("Por favor, completá todos tus datos para la entrega.");
                return;
            }

            // 2. Traemos el carrito de la memoria
            let carrito = JSON.parse(localStorage.getItem('miCarrito')) || [];
            let total = 0;

            // 3. Armamos el mensaje de texto
            let mensaje = `¡Hola Salvador! 🥦%0A`;
            mensaje += `Mi nombre es *${nombre}*.%0A`;
            mensaje += `Quisiera hacer el siguiente pedido:%0A%0A`;

            carrito.forEach(item => {
                mensaje += `- ${item.nombre}: $${item.precio}%0A`;
                total += item.precio;
            });

            mensaje += `%0A*Total: $${total}*%0A%0A`;
            mensaje += `📍 *Dirección:* ${direccion}%0A`;
            mensaje += `📱 *Teléfono:* ${telefono}`;

            // 4. Tu número de WhatsApp (poné el tuyo acá)
            const numeroWhatsApp = "5491138517333"; // Reemplazalo por el de Salvador

            // 5. ¡Abrimos WhatsApp!
            const url = `https://wa.me/${numeroWhatsApp}?text=${mensaje}`;
            window.open(url, '_blank');
        }
    </script>
</body>
</html>