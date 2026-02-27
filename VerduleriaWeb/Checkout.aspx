<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="VerduleriaWeb.Checkout" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="MiFooter" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Finalizar Pedido - Salvador</title>
     <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="Estilo.css" rel="stylesheet" type="text/css" />

</head>
<body>

    <form id="form1" runat="server">
        
   <nav class="navbar-moderna">
    <a href="Inicio.aspx" class="navbar-brand">
        <span>🥦 Salvador</span>
    </a>
    <div class="navbar-links">
        <a href="Inicio.aspx" class="nav-btn">Volver al Inicio</a>
    </div>
</nav>

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
            const nombre = document.getElementById("txtNombre").value;
            const direccion = document.getElementById("txtDireccion").value;
            const telefono = document.getElementById("txtTelefono").value;
            const totalTexto = document.getElementById("lblTotalCheckout").innerText.replace('$', '');

            if (!nombre || !direccion || !telefono) {
                alert("Por favor, completá los datos para la entrega en Victoria. 🚚");
                return;
            }

            // Llamada silenciosa al servidor para guardar el pedido antes de ir a WhatsApp
            PageMethods.GuardarPedido(nombre, direccion, telefono, parseFloat(totalTexto), function (resultado) {
                if (resultado) {
                    // Si se guardó en SQL, procedemos al WhatsApp
                    const mensaje = `Hola Salvador! 🥦 Pedido de: ${nombre}\nDirección: ${direccion}\nTotal: $${totalTexto}`;
                    const url = `https://wa.me/5491138517333?text=${encodeURIComponent(mensaje)}`;
                    window.open(url, '_blank');
                } else {
                    alert("Hubo un error al procesar el pedido, pero podés contactarnos por WhatsApp igual.");
                }
            });
        }
    </script>
</body>
</html>