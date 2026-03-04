<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Inicio.aspx.cs" Inherits="VerduleriaWeb.Inicio" %>

<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="MiFooter" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;800&display=swap" rel="stylesheet" />
    <title>Inicio - Verdulería Salvador</title>
    <link href="<%= ResolveUrl("~/Estilo.css?v=3") %>" rel="stylesheet" type="text/css" />

</head>
<body>
    <form id="form1" runat="server">
        
    <nav class="navbar-moderna">
    <a href="Inicio.aspx" class="navbar-brand">Salvador 🥦</a>
    
    <div class="navbar-links">
        <% if (Session["usuario"] != null) { %>
            <span style="color:white; margin-right: 10px; font-size: 0.9rem;">Hola, <b><%: ((Dominio.Usuario)Session["usuario"]).Nombre.Split(' ')[0] %></b></span>
            
            <a href="MisPedidos.aspx" class="nav-btn" style="padding: 6px 12px; font-size: 0.8rem;">Mis Pedidos</a>
            
            <asp:LinkButton ID="btnSalir" runat="server" CssClass="nav-btn ocultar-en-celu" Style="border-color: #ff8a80; color: #ff8a80; margin-left: 5px;" OnClick="btnSalir_Click">Salir</asp:LinkButton>
        <% } else { %>
            <a href="Login.aspx" class="nav-btn">Ingresar</a>
        <% } %>
    </div>
</nav>

        <div class="hero-banner" id="bannerPrincipal">

            <button type="button" class="flecha-slider flecha-izq" onclick="cambiarFotoManual(-1)">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round">
                    <polyline points="15 18 9 12 15 6"></polyline>
                </svg>
            </button>

            <button type="button" class="flecha-slider flecha-der" onclick="cambiarFotoManual(1)">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round">
                    <polyline points="9 18 15 12 9 6"></polyline>
                </svg>
            </button>

            <h1 class="hero-titulo" id="textoTitulo">PEDÍ TU COMBO SEMANAL</h1>
            <p class="hero-subtitulo" id="textoSubtitulo">Directo de la huerta a tu mesa, sin escalas.</p>
            <a href="Catalogo.aspx" class="btn-naranja">Ver Productos</a>
        </div>

        <div class="seccion-pasos">

            <div class="paso">
                <div class="icono-paso">🛒</div>
                <h4>1. Elegí lo que te gusta</h4>
                <p>Armá tu carrito con nuestros combos o seleccioná frutas y verduras a medida.</p>
            </div>

            <div class="paso">
                <div class="icono-paso">📝</div>
                <h4>2. Completá tus datos</h4>
                <p>Ingresá tu dirección de envío y coordiná la entrega de forma súper fácil.</p>
            </div>

            <div class="paso">
                <div class="icono-paso">🚚</div>
                <h4>3. Recibí el pedido</h4>
                <p>Nosotros nos encargamos del resto. ¡Te lo llevamos fresco hasta tu puerta!</p>
            </div>

        </div>

        <div class="seccion-info">
            <h2 style="color: #2e7d32; margin-bottom: 30px; text-align: center;">Nuestros Elegidos de la Semana</h2>

            <div class="tarjetas-container">

                <asp:Repeater ID="repCombos" runat="server">
                    <ItemTemplate>

                        <div class="tarjeta-combo">

                            <div class="etiqueta-oferta">OFERTA</div>

                            <div class="foto-combo" style="background-image: url('https://images.unsplash.com/photo-1542838132-92c53300491e?q=80&w=800&auto=format&fit=crop');"></div>

                            <div class="contenido-combo">
                                <h3 class="titulo-combo"><%# Eval("Nombre") %></h3>

                                <p class="desc-combo"><%# Eval("Descripcion") %></p>

                                <div class="precio-combo">$<%# Eval("Precio") %></div>

                                <button type="button" class="btn-pedir-combo"
                                    onclick="agregarCombo('<%# Eval("Nombre") %>', <%# Eval("Precio") %>)">
                                    Agregar al carrito 🛒
                                </button>
                            </div>

                        </div>

                    </ItemTemplate>
                </asp:Repeater>

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
    
    <a href="Checkout.aspx" class="nav-item">
        <div class="cart-wrapper" style="position: relative;">
            <span class="nav-icon">🛒</span>
            <span class="cart-badge" id="badgeMobile" style="position: absolute; top: -5px; right: -10px; background: #e63946; color: white; border-radius: 50%; padding: 2px 6px; font-size: 0.65rem; font-weight: bold;">0</span>
        </div>
        <span class="nav-label">Carrito</span>
    </a>
    <% if (Session["usuario"] != null) { %>
        <asp:LinkButton ID="btnSalirMobile" runat="server" CssClass="nav-item" OnClick="btnSalir_Click">
            <span class="nav-icon" style="color: #ff8a80;">🚪</span>
            <span class="nav-label" style="color: #ff8a80;">Salir</span>
        </asp:LinkButton>
    <% } else { %>
       
    <% } %>

</nav>

        <uc:MiFooter runat="server" />

    </form>
    <a href="Checkout.aspx" class="btn-flotante-carrito solo-pc" id="btnCarritoFlotante">🛒 Ver mi pedido
   
        <span class="badge-cantidad" id="lblCantidadCarrito">0</span>
    </a>

    <script>
        // --- 1. CONFIGURACIÓN DEL SLIDER (Fotos más livianas con &w=1200) ---
        const slides = [
            {
                foto: "https://images.unsplash.com/photo-1542838132-92c53300491e?q=70&w=1200&auto=format&fit=crop",
                titulo: "PEDÍ TU COMBO SALVADOR",
                subtitulo: "Directo de la huerta a tu mesa, sin escalas."
            },
            {
                foto: "https://images.unsplash.com/photo-1610348725531-843dff563e2c?q=70&w=1200&auto=format&fit=crop",
                titulo: "FRUTAS DE ESTACIÓN",
                subtitulo: "Llená tus días de sabor, energía y vitaminas."
            },
            {
                foto: "https://images.unsplash.com/photo-1573246123716-6b1782bfc499?q=70&w=1200&auto=format&fit=crop",
                titulo: "CALIDAD PREMIUM",
                subtitulo: "Elegimos la mejor mercadería para tu familia."
            }
        ];

        let indiceActual = 0;
        let timerSlider;

        function renderizarSlide() {
            const banner = document.getElementById("bannerPrincipal");
            const titulo = document.getElementById("textoTitulo");
            const subtitulo = document.getElementById("textoSubtitulo");

            // 1. Cambio de fondo inmediato
            banner.style.backgroundImage = `linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)), url('${slides[indiceActual].foto}')`;

            // 2. Cambio de texto inmediato (sin setTimeout)
            // Usamos una transición suave de CSS en lugar de JS
            titulo.innerText = slides[indiceActual].titulo;
            subtitulo.innerText = slides[indiceActual].subtitulo;
        }

        function cambiarFoto(direccion) {
            indiceActual = (indiceActual + direccion + slides.length) % slides.length;
            renderizarSlide();
        }

        function cambiarFotoManual(direccion) {
            clearInterval(timerSlider);
            cambiarFoto(direccion);
            timerSlider = setInterval(() => cambiarFoto(1), 5000);
        }

        // --- 2. FUNCIONES DEL CARRITO ---
        function actualizarBotonFlotante() {
            let carrito = JSON.parse(localStorage.getItem('miCarrito')) || [];
            let botonFlotante = document.getElementById("btnCarritoFlotante");
            let labelCantidad = document.getElementById("lblCantidadCarrito");
            let badgeMobile = document.getElementById("badgeMobile");

            if (badgeMobile) badgeMobile.innerText = carrito.length;

            if (carrito.length > 0) {
                if (botonFlotante) botonFlotante.style.display = "flex";
                if (labelCantidad) labelCantidad.innerText = carrito.length;
            } else {
                if (botonFlotante) botonFlotante.style.display = "none";
            }
        }

        function agregarCombo(nombreCombo, precioCombo) {
            let carrito = JSON.parse(localStorage.getItem('miCarrito')) || [];
            carrito.push({ nombre: nombreCombo, precio: precioCombo });
            localStorage.setItem('miCarrito', JSON.stringify(carrito));

            // Animación sutil en lugar de alert pesado
            actualizarBotonFlotante();
            console.log("Agregado: " + nombreCombo);
        }

        // --- ONLOAD ÚNICO ---
        window.onload = function () {
            renderizarSlide(); // Para que cargue el primer slide bien
            timerSlider = setInterval(() => cambiarFoto(1), 5000);
            actualizarBotonFlotante();
        };
    </script>


</body>
</html>
