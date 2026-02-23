

<style>
    /* =========================================
       FOOTER MODERNO
       ========================================= */
    .footer-moderno {
        background-color: #1b4332;
        color: #d8f3dc;
        padding: 40px 20px 20px;
        margin-top: 50px;
        font-family: 'Poppins', sans-serif;
    }

    .footer-contenedor {
        max-width: 1100px;
        margin: 0 auto;
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 30px;
        border-bottom: 1px solid rgba(255,255,255,0.1);
        padding-bottom: 30px;
    }

    .footer-columna h3 { color: white; font-size: 1.2rem; margin-top: 0; margin-bottom: 15px; }
    .footer-columna p { font-size: 0.9rem; line-height: 1.6; opacity: 0.8; }
    
    .footer-links { list-style: none; padding: 0; margin: 0; }
    .footer-links li { margin-bottom: 10px; }
    .footer-links a { color: #d8f3dc; text-decoration: none; font-size: 0.9rem; transition: color 0.2s; }
    .footer-links a:hover { color: white; }

    .footer-social { display: flex; gap: 15px; margin-top: 15px; }
    .footer-social a { color: white; font-size: 1.5rem; text-decoration: none; transition: transform 0.2s; }
    .footer-social a:hover { transform: translateY(-3px); }

    .footer-creditos { text-align: center; padding-top: 20px; font-size: 0.8rem; opacity: 0.6; }
</style>

<footer class="footer-moderno">
    <div class="footer-contenedor">
        
        <div class="footer-columna">
            <h3>Frutas y Verduras Salvador 🥦</h3>
            <p>Llevamos frescura y calidad directo de la huerta a la puerta de tu casa. Elegimos lo mejor para tu familia todos los días.</p>
        </div>

        <div class="footer-columna">
            <h3>Enlaces Rápidos</h3>
            <ul class="footer-links">
                <li><a href="Inicio.aspx">🏠 Inicio</a></li>
                <li><a href="Catalogo.aspx">🍎 Catálogo Completo</a></li>
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