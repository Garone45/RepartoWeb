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
            padding: 15px 10px;
        }
    }
</style>

<footer class="footer-moderno">
    <div class="footer-contenedor">
        <div class="footer-columna">
            <h3>Frutas y Verduras Salvador 🥦</h3>
            <p>Llevamos frescura y calidad directo de la huerta a tu mesa.</p>
        </div>

        <div class="footer-columna">
            <h3>Enlaces</h3>
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
