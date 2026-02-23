<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Inicio.aspx.cs" Inherits="VerduleriaWeb.Inicio" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="MiFooter" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;800&display=swap" rel="stylesheet" />
    <title>Inicio - Verdulería Salvador</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <style>
        /* =========================================
           BOTÓN FLOTANTE DEL CARRITO
           ========================================= */
        .btn-flotante-carrito {
            position: fixed;
            bottom: 25px;
            right: 25px;
            background-color: #ff9800; /* Naranja llamativo */
            color: white;
            padding: 15px 25px;
            border-radius: 50px;
            font-family: 'Poppins', sans-serif;
            font-size: 1.1rem;
            font-weight: 700;
            text-decoration: none;
            box-shadow: 0 5px 20px rgba(255, 152, 0, 0.4);
            display: none; /* Arranca oculto hasta que compren algo */
            z-index: 2000;
            align-items: center;
            gap: 10px;
            transition: transform 0.3s ease;
        }

        .btn-flotante-carrito:hover {
            transform: scale(1.05) translateY(-5px);
            background-color: #f57c00;
        }

        /* El circulito blanco que muestra la cantidad de cosas */
        .badge-cantidad {
            background-color: white;
            color: #ff9800;
            border-radius: 50%;
            padding: 2px 8px;
            font-size: 0.9rem;
            font-weight: 800;
        }
        body {
            margin: 0;
            padding: 0;
            font-family: 'Poppins', sans-serif;
            background-color: #f9f9f9;
        }

        /* NAVBAR (Igual a la del catálogo) */
        .navbar-moderna {
            /* Usamos tu verde, pero al 85% de opacidad para que deje ver el fondo */
            background: rgba(46, 125, 50, 0.85);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.15); /* Línea divisoria muy sutil */

            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 30px; /* Más aire a los costados y arriba */
            position: sticky;
            top: 0;
            z-index: 1000;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        }

        .navbar-brand {
            font-family: 'Poppins', sans-serif;
            font-size: 1.4rem;
            font-weight: 700;
            color: white;
            text-decoration: none;
            letter-spacing: -0.5px;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: opacity 0.3s;
        }

            .navbar-brand:hover {
                opacity: 0.8;
            }

        .navbar-links {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .nav-btn {
            font-family: 'Poppins', sans-serif;
            background: rgba(255, 255, 255, 0.1); /* Fondo translúcido en vez de outline duro */
            color: white;
            border: 1px solid rgba(255, 255, 255, 0.2);
            padding: 8px 20px;
            border-radius: 50px;
            text-decoration: none;
            font-size: 0.9rem;
            font-weight: 500; /* Letra un poco más fina, menos pesada */
            transition: all 0.3s ease;
            cursor: pointer;
        }

            .nav-btn:hover {
                background: white;
                color: #2e7d32;
                border-color: white;
                transform: translateY(-2px); /* Saltito sutil al pasar el mouse */
                box-shadow: 0 4px 10px rgba(0,0,0,0.15);
            }

        /* PORTADA GIGANTE (HERO BANNER) */
        .hero-banner {
            /* Acá cargamos una foto de fondo de verduras y le ponemos un filtro oscuro encima para que lea el texto */
            background: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)), url('https://images.unsplash.com/photo-1542838132-92c53300491e?q=80&w=1920&auto=format&fit=crop');
            background-size: cover;
            background-position: center;
            height: 60vh; /* Ocupa el 60% de la pantalla */
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            color: white;
            padding: 20px;
            position: relative; /* NUEVO: Para poder posicionar las flechas */
            transition: background-image 0.5s ease-in-out; /* NUEVO: Transición suave al cambiar de foto */
        }
        /* --- NUEVO: ESTILO DE LAS FLECHAS --- */
        .flecha-slider {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            /* Fondo semi-transparente con desenfoque atrás */
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: white;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            cursor: pointer;
            transition: all 0.3s ease;
            z-index: 10;
            display: flex;
            justify-content: center;
            align-items: center;
        }

            .flecha-slider:hover {
                background: rgba(255, 255, 255, 0.25);
                transform: translateY(-50%) scale(1.05); /* Se agranda un poquito al pasar el mouse */
            }

        .flecha-izq {
            left: 30px;
        }

        .flecha-der {
            right: 30px;
        }

        .flecha-slider svg {
            width: 24px;
            height: 24px;
            stroke-width: 2px;
        }

        /* BOTÓN NARANJA REFINADO */
        .btn-naranja {
            background-color: #f57c00; /* Un naranja apenas más oscuro/quemado */
            color: white;
            padding: 14px 32px;
            font-size: 1.1rem;
            font-weight: 600;
            text-decoration: none;
            border-radius: 50px;
            box-shadow: 0 8px 20px rgba(245, 124, 0, 0.3);
            transition: all 0.3s ease;
        }

            .btn-naranja:hover {
                transform: translateY(-3px);
                box-shadow: 0 12px 25px rgba(245, 124, 0, 0.4);
            }

        /* =========================================
           SECCIÓN DE COMBOS (GRILLA Y TARJETAS)
           ========================================= */
        .seccion-info {
            padding: 60px 20px;
            background-color: #f9f9f9;
        }

        .titulo-seccion {
            text-align: center;
            color: #2e7d32;
            font-size: 2rem;
            font-weight: 800;
            margin-bottom: 40px;
            letter-spacing: -0.5px;
        }

        .grilla-combos {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            max-width: 1100px;
            margin: 0 auto;
        }

        /* Estructura de la tarjeta */
        .tarjeta-combo {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.06);
            transition: all 0.3s ease;
            position: relative;
        }

            .tarjeta-combo:hover {
                transform: translateY(-10px);
                box-shadow: 0 15px 40px rgba(0,0,0,0.12);
            }

        /* Cartelito rojo arriba a la derecha */
        .etiqueta-oferta {
            position: absolute;
            top: 15px;
            right: 15px;
            background-color: #ff5252;
            color: white;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 700;
            z-index: 2;
        }

        /* Contenedor de la foto del combo */
        .foto-combo {
            width: 100%;
            height: 200px;
            background-color: #eee;
            background-size: cover;
            background-position: center;
        }

        .contenido-combo {
            padding: 25px;
            text-align: left;
        }

        /* Textos adentro de la tarjeta */
        .titulo-combo {
            font-size: 1.3rem;
            color: #333;
            font-weight: 700;
            margin: 0 0 10px 0;
        }

        .desc-combo {
            color: #666;
            font-size: 0.9rem;
            line-height: 1.5;
            margin-bottom: 20px;
            min-height: 40px; /* Para que todas las tarjetas queden parejas aunque tengan menos texto */
        }

        .precio-combo {
            font-size: 1.8rem;
            font-weight: 800;
            color: #2e7d32;
            margin-bottom: 20px;
        }

        /* Botón de Agregar al carrito */
        .btn-pedir-combo {
            display: block;
            width: 100%;
            text-align: center;
            background-color: #e8f5e9;
            color: #2e7d32;
            padding: 12px;
            border-radius: 12px;
            font-family: 'Poppins', sans-serif;
            font-size: 1rem;
            font-weight: 700;
            border: 2px solid transparent;
            cursor: pointer;
            transition: all 0.2s;
        }

            .btn-pedir-combo:hover {
                background-color: #2e7d32;
                color: white;
            }

        /* En celulares achicamos un poco las flechas */
        @media (max-width: 600px) {
            .flecha-slider {
                width: 40px;
                height: 40px;
                font-size: 18px;
            }

            .flecha-izq {
                left: 10px;
            }

            .flecha-der {
                right: 10px;
            }
        }

        .hero-titulo {
            font-size: 3.2rem;
            font-weight: 800;
            margin: 0 0 10px 0;
            letter-spacing: -1.5px;
            text-shadow: 0 4px 15px rgba(0,0,0,0.4);
            transition: opacity 0.3s ease; /* Para que el cambio de texto sea suave */
        }

        .hero-subtitulo {
            font-size: 1.2rem;
            margin-bottom: 35px;
            font-weight: 300;
            opacity: 0.9;
            letter-spacing: 0.5px;
            transition: opacity 0.3s ease; /* Para que el cambio de texto sea suave */
        }


        /* =========================================
           NUEVA SECCIÓN: CÓMO FUNCIONA (LOS 3 PASOS)
           ========================================= */
        .seccion-pasos {
            display: flex;
            justify-content: space-around;
            align-items: flex-start;
            padding: 40px 20px;
            background-color: #ffffff;
            text-align: center;
            flex-wrap: wrap;
            gap: 20px;
            border-bottom: 1px solid #eee;
        }

        .paso {
            flex: 1;
            min-width: 250px;
            padding: 15px;
        }

        .icono-paso {
            font-size: 3.5rem; /* Tamaño de los emojis/iconos */
            margin-bottom: 15px;
            /* Le damos un efectito de sombra a los emojis para que destaquen */
            filter: drop-shadow(0px 5px 10px rgba(46, 125, 50, 0.2));
        }

        .paso h4 {
            color: #2e7d32;
            font-size: 1.3rem;
            margin: 0 0 10px 0;
            font-weight: 700;
        }

        .paso p {
            color: #666;
            font-size: 0.95rem;
            margin: 0;
            line-height: 1.5;
        }

        .btn-naranja {
            background-color: #ff9800;
            color: white;
            padding: 15px 35px;
            font-size: 1.2rem;
            font-weight: bold;
            text-decoration: none;
            border-radius: 50px;
            box-shadow: 0 4px 15px rgba(255, 152, 0, 0.4);
            transition: transform 0.2s;
        }

            .btn-naranja:active {
                transform: scale(0.95);
            }

        /* SECCIÓN DE COMBOS RÁPIDA */
        .seccion-info {
            padding: 40px 20px;
            text-align: center;
        }

            .seccion-info h2 {
                color: #2e7d32;
                margin-bottom: 20px;
            }

        .tarjetas-container {
            display: flex;
            gap: 20px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .tarjeta-combo {
            background: white;
            border-radius: 15px;
            padding: 20px;
            width: 100%;
            max-width: 300px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            text-align: center;
        }

        .navbar-moderna {
            padding: 12px 15px;
        }

        .navbar-brand {
            font-size: 1.2rem;
        }

        .navbar-links {
            gap: 10px;
        }

        .nav-btn {
            padding: 6px 14px;
            font-size: 0.85rem;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <nav class="navbar-moderna">
            <a href="Inicio.aspx" class="navbar-brand">🥦 Salvador</a>
            <div class="navbar-links">
                <% if (Session["usuario"] != null)
                    { %>
                <a href="MisPedidos.aspx" class="nav-btn">👤 Pedidos</a>
                <% }
                else
                { %>
                <a href="Login.aspx" class="nav-btn" style="background: white; color: #2e7d32;">🔐 Ingresar</a>
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

            <h1 class="hero-titulo" id="textoTitulo">PEDÍ TU COMBO SALVADOR</h1>
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

        <uc:MiFooter runat="server" />

    </form>
    <a href="Checkout.aspx" class="btn-flotante-carrito" id="btnCarritoFlotante">
            🛒 Ver mi pedido
            <span class="badge-cantidad" id="lblCantidadCarrito">0</span>
        </a>

   <script>
       // --- 1. CONFIGURACIÓN DEL SLIDER ---
       const slides = [
           {
               foto: "https://images.unsplash.com/photo-1542838132-92c53300491e?q=80&w=1920&auto=format&fit=crop",
               titulo: "PEDÍ TU COMBO SALVADOR",
               subtitulo: "Directo de la huerta a tu mesa, sin escalas."
           },
           {
               foto: "https://images.unsplash.com/photo-1610348725531-843dff563e2c?q=80&w=1920&auto=format&fit=crop",
               titulo: "FRUTAS DE ESTACIÓN",
               subtitulo: "Llená tus días de sabor, energía y vitaminas."
           },
           {
               foto: "https://images.unsplash.com/photo-1573246123716-6b1782bfc499?q=80&w=1920&auto=format&fit=crop",
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

           banner.style.backgroundImage = `linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)), url('${slides[indiceActual].foto}')`;

           titulo.style.opacity = 0;
           subtitulo.style.opacity = 0;

           setTimeout(() => {
               titulo.innerText = slides[indiceActual].titulo;
               subtitulo.innerText = slides[indiceActual].subtitulo;
               titulo.style.opacity = 1;
               subtitulo.style.opacity = 1;
           }, 300);
       }

       function cambiarFoto(direccion) {
           indiceActual += direccion;

           if (indiceActual >= slides.length) {
               indiceActual = 0;
           } else if (indiceActual < 0) {
               indiceActual = slides.length - 1;
           }

           renderizarSlide();
       }

       function cambiarFotoManual(direccion) {
           cambiarFoto(direccion);
           clearInterval(timerSlider);
           timerSlider = setInterval(() => cambiarFoto(1), 5000);
       }

       window.onload = function () {
           timerSlider = setInterval(() => cambiarFoto(1), 5000);
       };

       // --- 2. FUNCIÓN PARA EL CARRITO Y LOS COMBOS ---
       function agregarCombo(nombreCombo, precioCombo) {
           let carrito = JSON.parse(localStorage.getItem('miCarrito')) || [];
           carrito.push({ nombre: nombreCombo, precio: precioCombo });
           localStorage.setItem('miCarrito', JSON.stringify(carrito));
           window.location.href = "Catalogo.aspx";
       }
       function actualizarBotonFlotante() {
           let carrito = JSON.parse(localStorage.getItem('miCarrito')) || [];
           let botonFlotante = document.getElementById("btnCarritoFlotante");
           let labelCantidad = document.getElementById("lblCantidadCarrito");

           if (carrito.length > 0) {
               // Si hay cosas en el carrito, mostramos el botón y la cantidad
               botonFlotante.style.display = "flex";
               labelCantidad.innerText = carrito.length;
           } else {
               // Si está vacío, lo ocultamos
               botonFlotante.style.display = "none";
           }
       }

       // --- FUNCIÓN ACTUALIZADA PARA AGREGAR COMBOS ---
       function agregarCombo(nombreCombo, precioCombo) {
           let carrito = JSON.parse(localStorage.getItem('miCarrito')) || [];
           carrito.push({ nombre: nombreCombo, precio: precioCombo });
           localStorage.setItem('miCarrito', JSON.stringify(carrito));

           // Le avisamos al usuario sin cambiarlo de página
           alert("¡Excelente! Agregamos " + nombreCombo + " a tu pedido. 🥦");

           // Encendemos el botón flotante al instante
           actualizarBotonFlotante();
       }

       // --- IMPORTANTE: ACTUALIZAR EL ONLOAD ---
       window.onload = function () {
           timerSlider = setInterval(() => cambiarFoto(1), 5000);

           // Apenas carga la página de inicio, se fija si ya tenías cosas de antes para mostrar el botón
           actualizarBotonFlotante();
       };
   </script>


</body>
</html>
