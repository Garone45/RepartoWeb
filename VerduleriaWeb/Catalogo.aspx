<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Catalogo.aspx.cs" Inherits="VerduleriaWeb.Catalogo" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Catálogo - Salvador</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;800&display=swap" rel="stylesheet"/>
    
  <link href="Estilo.css?v=3" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">


        <nav class="navbar-moderna">
            <a href="Inicio.aspx" class="navbar-brand">🥦 SALVADOR</a>
            <div class="navbar-links">

                <% if (Session["usuario"] != null) { %>
                   
             
                <% } else { %>
                    <a href="Login.aspx" class="nav-btn" style="background-color: white; color: #2e7d32; border: none;">🔐 Ingresar</a>
                <% } %>
            </div>
        </nav>

        <div class="seccion-filtros">
            <div class="contenedor-buscador">
                <input type="text" id="txtBuscador" class="input-busqueda" placeholder="¿Qué buscás hoy?" onkeyup="filtrarProductos()" />
            </div>
            <div class="tabs-categorias">
                <button type="button" class="tab-btn active" onclick="filtrarCategoria('todas', this)">Todas</button>
                <button type="button" class="tab-btn" onclick="filtrarCategoria('Verduras', this)">Verduras</button>
                <button type="button" class="tab-btn" onclick="filtrarCategoria('Frutas', this)">Frutas</button>
                <button type="button" class="tab-btn" onclick="filtrarCategoria('Combos', this)">Combos</button>
            </div>
        </div>

        <div class="grid-productos" id="contenedorProductos">
            <asp:Repeater ID="repProductos" runat="server">
                <ItemTemplate>
                    <div class="card-producto" data-nombre="<%# Eval("Nombre") %>" data-categoria="<%# Eval("Categoria.Nombre") %>">
                        <div class="img-placeholder">
                            <%# Eval("Categoria.Nombre").ToString() == "Frutas" ? "🍎" : Eval("Categoria.Nombre").ToString() == "Combos" ? "📦" : "🥦" %>
                        </div>
                        <div class="info-producto">
                            <span class="cat-tag"><%# Eval("Categoria.Nombre") %></span>
                            <h3 class="nombre-p"><%# Eval("Nombre") %></h3>
                            <p class="desc-p"><%# Eval("Descripcion") %></p>
                            <div class="footer-card">
                                <span class="precio-p">$<%# Eval("Precio") %></span>
                                <button type="button" class="btn-mini-add" onclick="agregarAlCarrito('<%# Eval("Nombre") %>', <%# Eval("Precio") %>)">+</button>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <div id="btn-flotante" onclick="abrirResumen()">
            <span>🛒 VER PEDIDO</span>
            <span id="total-carrito-badge">$0</span>
        </div>

        <div id="modal-fondo" class="modal-overlay">
            <div class="modal-caja">
                <div class="modal-header-simple">
                    <h2 style="margin:0; font-size:1.2rem;">Tu Pedido 🥦</h2>
                    <span style="font-size:1.8rem; cursor:pointer;" onclick="cerrarResumen()">&times;</span>
                </div>
                
                <div id="lista-detalle" class="modal-body-scroll">
                    </div>

                <div class="datos-cliente-form">
                    <h4 style="margin: 10px 0; color: #2e7d32;">📍 Datos de Envío</h4>
                    <input type="text" id="txtClienteNombre" placeholder="Tu Nombre" class="input-datos" />
                    <input type="text" id="txtClienteDireccion" placeholder="Dirección de entrega" class="input-datos" />
                    <textarea id="txtAclaraciones" placeholder="¿Alguna aclaración?" class="input-datos" rows="2"></textarea>
                </div>

                <div class="modal-footer-final">
                    <div class="total-final">Total: <span id="modal-total">$0</span></div>

                    <asp:HiddenField ID="hfCarritoJson" runat="server" />
                    <asp:HiddenField ID="hfNombre" runat="server" />
                    <asp:HiddenField ID="hfDireccion" runat="server" />
                    <asp:HiddenField ID="hfAclaraciones" runat="server" />

                    <asp:Button ID="btnFinalizar" runat="server" Text="✅ Confirmar y Pagar" 
                        CssClass="btn-whatsapp-final" 
                        OnClientClick="return prepararDatosParaServer();" 
                        OnClick="btnFinalizar_Click" />
            </div>
        </div>
                </div>
 <nav class="mobile-nav">
    <a href="Inicio.aspx" class="nav-item" style="color: #2e7d32;">
        <span class="nav-icon">🏠</span>
        <span class="nav-label">Inicio</span>
    </a>
    
    <a href="Catalogo.aspx" class="nav-item">
        <span class="nav-icon">🍎</span>
        <span class="nav-label">Tienda</span>
    </a>
    
    <asp:LinkButton ID="btnSalirMobile" runat="server" CssClass="nav-item" OnClick="btnSalir_Click">
        <span class="nav-icon" style="color: #ff8a80;">🚪</span>
        <span class="nav-label" style="color: #ff8a80;">Salir</span>
    </asp:LinkButton>

    <a href="Checkout.aspx" class="nav-item">
        <div class="cart-wrapper" style="position: relative;">
            <span class="nav-icon">🛒</span>
            <span class="cart-badge" id="badgeMobile" style="position: absolute; top: -5px; right: -10px; background: #e63946; color: white; border-radius: 50%; padding: 2px 6px; font-size: 0.65rem; font-weight: bold;">0</span>
        </div>
        <span class="nav-label">Carrito</span>
    </a>
</nav>
    </form>

    <script>
        // Lógica del Carrito
        let carrito = JSON.parse(localStorage.getItem('miCarrito')) || [];
        
        window.onload = function() {
            actualizarBotonFlotante();
            if (localStorage.getItem('clienteNombre')) document.getElementById('txtClienteNombre').value = localStorage.getItem('clienteNombre');
            if (localStorage.getItem('clienteDireccion')) document.getElementById('txtClienteDireccion').value = localStorage.getItem('clienteDireccion');
        };

        function agregarAlCarrito(nombre, precio) {
            carrito.push({ nombre: nombre, precio: precio });
            localStorage.setItem('miCarrito', JSON.stringify(carrito));
            actualizarBotonFlotante();
            
            // Efecto visual de rebote en el botón
            const btn = document.getElementById('btn-flotante');
            btn.style.transform = 'translateX(-50%) scale(1.1)';
            setTimeout(() => btn.style.transform = 'translateX(-50%) scale(1)', 200);
        }

        function actualizarBotonFlotante() {
            const btn = document.getElementById('btn-flotante');
            const badge = document.getElementById('total-carrito-badge');
            const badgeMobile = document.getElementById('badgeMobile'); // Capturamos el numerito del navbar

            // Actualizamos la cantidad de ítems en la burbuja roja
            if (badgeMobile) {
                badgeMobile.innerText = carrito.length;
            }

            if (carrito.length > 0) {
                btn.style.display = 'flex';
                const total = carrito.reduce((s, p) => s + p.precio, 0);
                badge.innerText = "$" + total;
            } else {
                btn.style.display = 'none';
            }
        }

        // Filtros
        function filtrarProductos() {
            const busqueda = document.getElementById("txtBuscador").value.toUpperCase();
            const cards = document.querySelectorAll(".card-producto");
            cards.forEach(card => {
                const nombre = card.getAttribute("data-nombre").toUpperCase();
                card.style.display = nombre.includes(busqueda) ? "" : "none";
            });
        }

        function filtrarCategoria(cat, btn) {
            document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            const cards = document.querySelectorAll(".card-producto");
            cards.forEach(card => {
                const categoria = card.getAttribute("data-categoria");
                card.style.display = (cat === 'todas' || categoria === cat) ? "" : "none";
            });
        }

        // Modal y Gestión de Items
        function abrirResumen() {
            const lista = document.getElementById('lista-detalle');
            lista.innerHTML = "";
            let total = 0;
            carrito.forEach((p, i) => {
                total += p.precio;
                lista.innerHTML += `
                    <div style="display:flex; justify-content:space-between; padding:12px 0; border-bottom:1px solid #eee; align-items:center;">
                        <span style="font-size:0.9rem; font-weight:600;">${p.nombre}</span>
                        <div style="display:flex; gap:10px; align-items:center;">
                            <span style="color:#2e7d32; font-weight:bold;">$${p.precio}</span>
                            <button type="button" onclick="borrarItem(${i})" style="border:none; background:none; font-size:1.1rem; cursor:pointer;">🗑️</button>
                        </div>
                    </div>`;
            });
            document.getElementById('modal-total').innerText = "$" + total;
            document.getElementById('modal-fondo').style.display = 'flex';
        }

        function borrarItem(i) {
            carrito.splice(i, 1);
            localStorage.setItem('miCarrito', JSON.stringify(carrito));
            actualizarBotonFlotante();
            if (carrito.length === 0) cerrarResumen(); else abrirResumen();
        }

        function cerrarResumen() { document.getElementById('modal-fondo').style.display = 'none'; }

        // El Puente con el Servidor (C#)
        function prepararDatosParaServer() {
            const nombre = document.getElementById('txtClienteNombre').value.trim();
            const direccion = document.getElementById('txtClienteDireccion').value.trim();
            const aclaraciones = document.getElementById('txtAclaraciones').value.trim();

            if (nombre === "" || direccion === "") {
                alert("⚠️ Por favor, completá tu nombre y dirección para el envío.");
                return false;
            }

            if (carrito.length === 0) {
                alert("⚠️ El carrito está vacío.");
                return false;
            }

            // Guardamos localmente para conveniencia del usuario
            localStorage.setItem('clienteNombre', nombre);
            localStorage.setItem('clienteDireccion', direccion);

            // Pasamos los datos a los HiddenFields de ASP.NET
            document.getElementById('<%= hfCarritoJson.ClientID %>').value = JSON.stringify(carrito);
            document.getElementById('<%= hfNombre.ClientID %>').value = nombre;
            document.getElementById('<%= hfDireccion.ClientID %>').value = direccion;
            document.getElementById('<%= hfAclaraciones.ClientID %>').value = aclaraciones;

            return true; // Permite el PostBack al servidor
        }
    </script>
</body>
</html>