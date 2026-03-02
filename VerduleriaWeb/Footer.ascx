<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Footer.ascx.cs" Inherits="VerduleriaWeb.Footer" %>
<%@ Import Namespace="Dominio" %>
<style>
    /* =========================================
       FOOTER COMPACTO - SALVADOR
       ========================================= */
    .footer-moderno {
        background-color: #1b4332; /* Tu verde oscuro */
        color: #d8f3dc;
        padding: 25px 20px 15px; /* Bajamos de 40px a 25px */
        margin-top: 30px; /* Menos separación con el contenido */
        font-family: 'Poppins', sans-serif;
    }

    .footer-contenedor {
        max-width: 1100px;
        margin: 0 auto;
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); /* Columnas un poco más angostas */
        gap: 20px; /* Menos espacio entre columnas */
        border-bottom: 1px solid rgba(255,255,255,0.05);
        padding-bottom: 20px;
    }

    .footer-columna h3 {
        color: white;
        font-size: 1rem; /* Bajamos de 1.2rem a 1rem */
        margin-top: 0;
        margin-bottom: 10px;
    }

    .footer-columna p {
        font-size: 0.85rem; /* Letra más chica */
        line-height: 1.4;
        opacity: 0.7;
    }

    .footer-links {
        list-style: none;
        padding: 0;
        margin: 0;
    }

        .footer-links li {
            margin-bottom: 12px; /* Más espacio entre botones para que no se pisen */
        }

        .footer-links a {
            color: #d8f3dc;
            text-decoration: none;
            font-size: 0.9rem;
            transition: all 0.2s;
            display: inline-block; /* Importante para que tome bien el margen */
            padding: 5px 0;
        }

            .footer-links a:hover {
                color: white;
                transform: translateX(5px); /* Efecto sutil al pasar el mouse */
                font-weight: 600;
            }

    .footer-social {
        gap: 12px;
        margin-top: 10px;
    }

        .footer-social a {
            color: white;
            font-size: 1.4rem;
            text-decoration: none;
            display: inline-block;
            padding: 10px; /* Area de clic más grande */
            transition: transform 0.2s;
        }

    .footer-creditos {
        text-align: center;
        padding-top: 15px;
        font-size: 0.75rem;
        opacity: 0.5;
    }

    /* Ocultar descripción en móviles para que sea aún más chico */
    @media (max-width: 600px) {
        .footer-columna:first-child {
            display: none;
        }

        .footer-moderno {
            padding: 15px 10px; /* Reducimos el aire arriba y abajo */
        }

        .columna-links {
            display: none !important;
        }

        .footer-contenedor {
            text-align: center;
        }

        .footer-columna h3 {
            font-size: 0.9rem; /* Títulos más discretos */
            margin-bottom: 8px;
        }

        .footer-links {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 15px;
        }

            .footer-links li {
                margin-bottom: 0; /* Quitamos el margen inferior */
            }

        /* Iconos sociales más juntos */
        .footer-social {
            justify-content: center;
        }
    }
    .link-admin {
        color: #ffca28 !important; /* Un amarillo/dorado para que sepas que es especial */
        font-weight: bold;
        border: 1px dashed #ffca28;
        padding: 2px 8px;
        border-radius: 4px;
        margin-top: 5px;
        display: inline-block;
    }
    .link-admin:hover {
        background-color: #ffca28;
        color: #1b4332 !important;
    }
</style>

<footer class="footer-moderno">
    <div class="footer-contenedor">
        <div class="footer-columna">
            <h3>Frutas y Verduras Salvador 🥦</h3>
            <p>Llevamos frescura y calidad directo de la huerta a tu mesa.</p>
        </div>

        <div class="footer-columna columna-links">
            <h3>Enlaces Rápidos</h3>
            <ul class="footer-links">
                <li><a href="Inicio.aspx">🏠 Inicio</a></li>
                <li><a href="Catalogo.aspx">🍎 Catálogo</a></li>
                <li><a href="Checkout.aspx">🛒 Mi Pedido</a></li>
            </ul>
        </div>

        <div class="footer-columna">
            <h3>Contacto</h3>
            <ul class="footer-links">
                <li>📍 Victoria, Buenos Aires</li>
                <li>📱 WhatsApp: +54 9 11 1234-5678</li>
                
 
                <% 
                    // Al haber importado 'Dominio' arriba, ya podemos usar 'Usuario' directamente
                    // Usamos 'as' para una conversión segura
                    Usuario user = Session["usuario"] as Usuario; 

                    if (user != null && user.EsAdmin) 
                    { 
                %>
                    <li style="margin-top: 15px;">
                        <a href="AdminProductos.aspx" class="link-admin">⚙️ GESTIONAR PRODUCTOS</a>
                    </li>
                    <li>
                        <a href="AdminPedidos.aspx" class="link-admin">📋 VER PEDIDOS</a>
                    </li>
                <% } %>

                     

            </ul>
            <div class="footer-social">
                <a href="#" title="Instagram">📷</a>
                <a href="#" title="WhatsApp">💬</a>
                <a href="#" title="Facebook">📘</a>
            </div>
        </div>
    </div>
    <div class="footer-creditos">
        &copy; 2026 Frutas y Verduras Salvador. Desarrollado por Francisco.
    </div>
</footer>