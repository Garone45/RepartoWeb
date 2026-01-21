<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Catalogo.aspx.cs" Inherits="VerduleriaWeb.Catalogo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Lista de Precios - Verdulería</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
 <style>
    /* =========================================
       1. ESTILOS GENERALES
       ========================================= */
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #fff;
        margin: 0;
        padding: 0;
    }

    .header {
        background-color: #2e7d32;
        color: white;
        padding: 15px;
        text-align: center;
        box-shadow: 0 2px 5px rgba(0,0,0,0.2);
    }

    .header h1 {
        margin: 0;
        font-size: 1.5rem;
    }

    .contenedor-lista {
        max-width: 800px;
        margin: 20px auto;
        padding: 0 10px;
    }

    /* =========================================
       2. TABLA DE PRODUCTOS (DISEÑO HÍBRIDO)
       ========================================= */
    table {
        width: 100%;
        border-collapse: collapse;
        background-color: white;
        margin-bottom: 80px; /* Espacio para el botón flotante */
    }

    th {
        background-color: #f1f1f1;
        text-align: left;
        padding: 12px;
        border-bottom: 2px solid #ddd;
        color: #333;
        font-weight: 600;
    }

    td {
        padding: 12px;
        border-bottom: 1px solid #eee;
        vertical-align: middle;
    }

    tr:nth-child(even) {
        background-color: #fcfcfc;
    }

    /* --- Estilos de Textos --- */
    .nombre-prod {
        font-size: 1.05rem;
        font-weight: 600;
        color: #333;
        display: block;
        margin-top: 2px;
    }

    .desc-prod {
        font-size: 0.85rem;
        color: #777;
        margin-top: 2px;
        line-height: 1.2;
    }

    .badge {
        background-color: #e8f5e9;
        color: #2e7d32;
        padding: 2px 6px;
        border-radius: 4px;
        font-size: 0.7rem;
        text-transform: uppercase;
        font-weight: bold;
        display: inline-block;
    }

    /* --- LÓGICA PC vs CELULAR --- */
    
    /* Por defecto (PC), ocultamos lo que es "solo celular" */
    .solo-celu {
        display: none !important;
    }

    /* Estilo de la columna Precio en PC */
    .col-precio {
        font-weight: bold;
        color: #2e7d32;
        font-size: 1.1rem;
        vertical-align: middle;
    }

    /* Alineamos el botón a la derecha */
    .accion-flex {
        display: flex;
        justify-content: flex-end;
        align-items: center;
        gap: 10px;
    }

    .btn-add {
        width: 45px;
        height: 45px;
        border-radius: 8px;
        background-color: #eee;
        border: 1px solid #ddd;
        font-size: 1.6rem;
        color: #333;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: all 0.2s;
        padding-bottom: 4px;
    }

    .btn-add:hover {
        background-color: #2e7d32;
        color: white;
        border-color: #2e7d32;
    }

    /* =========================================
       3. ESTILOS DEL MODAL (VENTANA EMERGENTE)
       ========================================= */
    .modal-overlay {
        position: fixed;
        top: 0; left: 0; width: 100%; height: 100%;
        background-color: rgba(0,0,0,0.5);
        z-index: 2000;
        display: none; /* Por defecto oculto */
        justify-content: center;
        align-items: center;
        backdrop-filter: blur(2px);
    }

    .modal-caja {
        background-color: white;
        width: 90%;
        max-width: 500px;
        border-radius: 15px;
        box-shadow: 0 10px 25px rgba(0,0,0,0.2);
        overflow: hidden;
        animation: aparecer 0.3s ease-out;
        display: flex;
        flex-direction: column;
        max-height: 90vh;
    }

    @keyframes aparecer {
        from { transform: translateY(20px); opacity: 0; }
        to { transform: translateY(0); opacity: 1; }
    }

    .modal-header {
        background-color: #2e7d32;
        color: white;
        padding: 15px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .cerrar-modal {
        font-size: 1.8rem;
        cursor: pointer;
        line-height: 0.8;
    }

    .modal-body {
        overflow-y: auto;
        padding: 15px;
        flex-grow: 1;
    }

    .item-resumen {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 10px 0;
        border-bottom: 1px solid #eee;
    }

    .btn-borrar {
        color: #ff4444;
        background: none; border: none;
        font-size: 1.2rem; cursor: pointer;
        margin-left: 10px;
    }

    .datos-cliente {
        padding: 15px;
        background: #f8f8f8;
        border-top: 1px solid #ddd;
    }

    .input-datos {
        width: 100%;
        padding: 12px;
        margin-bottom: 10px;
        border: 1px solid #ccc;
        border-radius: 8px;
        font-size: 1rem;
        box-sizing: border-box;
    }

    .modal-footer {
        padding: 15px;
        background-color: #fff;
        border-top: 1px solid #eee;
        text-align: center;
    }

    .total-final {
        font-size: 1.4rem;
        font-weight: 800;
        color: #2e7d32;
        margin-bottom: 15px;
    }

    .btn-whatsapp-final {
        background-color: #25D366;
        color: white;
        border: none;
        padding: 14px;
        font-size: 1.1rem;
        font-weight: bold;
        border-radius: 50px;
        cursor: pointer;
        width: 100%;
        box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        transition: background 0.2s;
    }
    .btn-whatsapp-final:hover { background-color: #128C7E; }

    /* =========================================
       4. MEDIA QUERY: MODO CELULAR
       ========================================= */
    @media (max-width: 600px) {
        
        /* 1. Ocultamos el encabezado y la columna de Precio de PC */
        thead, .solo-pc {
            display: none !important;
        }

        /* 2. Mostramos el Precio "Mobile" que pusimos al lado del botón */
        .solo-celu {
            display: inline-block !important;
            font-weight: bold;
            color: #2e7d32;
            font-size: 1.1rem;
            margin-right: 8px;
        }

        /* 3. Ajustes de estructura */
        .contenedor-lista {
            padding: 0;
            margin-top: 0;
        }

        table {
            border: none;
        }

        .col-info {
            width: 100%; /* Que el texto ocupe todo */
        }

        .col-accion {
            width: 1%; /* Que esta columna se achique */
            white-space: nowrap;
        }

        /* 4. Textos más chicos para celu */
        .nombre-prod { font-size: 1rem; }
        .desc-prod { font-size: 0.8rem; }
        
        .badge { 
            font-size: 0.65rem; 
            margin-bottom: 2px;
        }

        .btn-add {
            width: 40px !important;
            height: 40px !important;
            font-size: 1.4rem !important;
        }
    }
</style>
</head>
<body>

    <form id="form1" runat="server">

        <div class="header">
            <h1>🥦 Hacé tu Pedido</h1>
        </div>

        <div class="contenedor-lista">
            <div style="max-width: 800px; margin: 20px auto; padding: 0 10px;">
                <input type="text" id="txtBuscador" onkeyup="filtrarTabla()"
                    placeholder="🔍 Buscar producto..."
                    style="width: 100%; padding: 12px; font-size: 1rem; border: 1px solid #ddd; border-radius: 8px; box-sizing: border-box;" />
            </div>

   <table class="table">
    <thead>
        <tr>
            <th>Producto</th>
            
            <th class="solo-pc" style="width: 100px;">Precio</th>
            
            <th style="text-align:right; width: 80px;">Agregar</th>
        </tr>
    </thead>
    <tbody>
        <asp:Repeater ID="repProductos" runat="server">
            <ItemTemplate>
                <tr>
                    <td class="col-info">
                        <span class="badge"><%# Eval("Categoria.Nombre") %></span>
                        <div class="nombre-prod"><%# Eval("Nombre") %></div>
                        <div class="desc-prod"><%# Eval("Descripcion") %></div>
                    </td>

                    <td class="col-precio solo-pc">
                        $<%# Eval("Precio") %>
                    </td>

                    <td class="col-accion">
                        <div class="accion-flex">
                            <span class="precio-mobile solo-celu">$<%# Eval("Precio") %></span>
                            
                            <button type="button" class="btn-add" onclick="agregarAlCarrito('<%# Eval("Nombre") %>', <%# Eval("Precio") %>)">
                                +
                            </button>
                        </div>
                    </td>
                </tr>
            </ItemTemplate>
        </asp:Repeater>
    </tbody>
</table>
        </div>

        <div style="height: 100px;"></div>

        <div id="btn-flotante" onclick="abrirResumen()" style="display: none; position: fixed; bottom: 20px; right: 20px; background-color: #25D366; color: white; padding: 15px 25px; border-radius: 50px; box-shadow: 0 4px 10px rgba(0,0,0,0.3); cursor: pointer; font-size: 1.2rem; align-items: center;">
            <span>🛒 Ver Pedido</span>
            <span id="total-carrito" style="font-weight: bold; background: white; color: #25D366; padding: 2px 8px; border-radius: 10px; margin-left: 10px;">$0</span>
        </div>
        <div id="modal-fondo" class="modal-overlay" style="display: none;">

            <div class="modal-caja">
                <div class="modal-header">
                    <h2>📝 Revisá tu Pedido</h2>
                    <span class="cerrar-modal" onclick="cerrarResumen()">&times;</span>
                </div>

                <div id="lista-detalle" class="modal-body">
                </div>

                <div class="datos-cliente" style="padding: 15px; background: #f0f0f0; border-top: 1px solid #ddd;">
                    <h4 style="margin-top: 0; color: #2e7d32;">📍 Datos de Envío</h4>

                    <input type="text" id="txtClienteNombre" placeholder="Tu Nombre" class="input-datos" />
                    <input type="text" id="txtClienteDireccion" placeholder="Dirección de entrega" class="input-datos" />

                    <textarea id="txtAclaraciones" placeholder="¿Alguna aclaración? (Ej: Timbre no anda, casa esquina...)" class="input-datos" rows="2"></textarea>
                </div>

                <div class="modal-footer">
                    <div class="total-final">Total: <span id="modal-total">$0</span></div>

                    <button type="button" class="btn-whatsapp-final" onclick="confirmarYEnviar()">
                        ✅ Confirmar Pedido
                    </button>
                </div>
            </div>
        </div>

    </form>

    <script>
        // 1. CARGAMOS EL CARRITO
        let carrito = JSON.parse(localStorage.getItem('miCarrito')) || [];
        actualizarBotonFlotante(); // Actualizamos al entrar por si quedó algo guardado

        // 2. AGREGAR PRODUCTO (Igual que antes)
        function agregarAlCarrito(nombre, precio) {
            carrito.push({ nombre: nombre, precio: precio });
            guardarYActualizar();

            // Efecto visual en el botón flotante
            const btn = document.getElementById('btn-flotante');
            btn.classList.add('vibrar');
            setTimeout(() => btn.classList.remove('vibrar'), 200);
        }

        // 3. FUNCIÓN AUXILIAR PARA GUARDAR
        function guardarYActualizar() {
            localStorage.setItem('miCarrito', JSON.stringify(carrito));
            actualizarBotonFlotante();
        }

        // 4. ACTUALIZAR EL BOTÓN VERDE FLOTANTE (Solo muestra el total)
        function actualizarBotonFlotante() {
            const btn = document.getElementById('btn-flotante');
            const lblTotal = document.getElementById('total-carrito');

            if (carrito.length === 0) {
                btn.style.display = 'none';
            } else {
                btn.style.display = 'flex';
                const total = carrito.reduce((suma, prod) => suma + prod.precio, 0);
                lblTotal.innerText = "$" + total;
            }
        }

        // ======================================================
        // NUEVAS FUNCIONES PARA EL MODAL (RESUMEN)
        // ======================================================

        // A. ABRIR EL MODAL (Se llama al hacer click en el botón flotante)
        function abrirResumen() {
            const modal = document.getElementById('modal-fondo');
            const contenedorLista = document.getElementById('lista-detalle');
            const lblTotalModal = document.getElementById('modal-total');

            // Limpiamos la lista anterior para no duplicar
            contenedorLista.innerHTML = "";
            let total = 0;

            // Recorremos el carrito y creamos el HTML de cada renglón
            carrito.forEach((prod, indice) => {
                total += prod.precio;

                // Creamos el renglón HTML
                const div = document.createElement('div');
                div.className = 'item-resumen';
                div.innerHTML = `
                <div>
                    <strong>${prod.nombre}</strong>
                </div>
                <div style="display:flex; align-items:center;">
                    <span>$${prod.precio}</span>
                    <button class="btn-borrar" onclick="borrarItem(${indice})">🗑️</button>
                </div>
            `;
                contenedorLista.appendChild(div);
            });

            // Actualizamos el total del modal
            lblTotalModal.innerText = "$" + total;

            // Mostramos el modal
            modal.style.display = 'flex';
        }

        // B. CERRAR EL MODAL
        function cerrarResumen() {
            document.getElementById('modal-fondo').style.display = 'none';
        }

        // C. BORRAR UN ITEM ESPECÍFICO (Desde el tachito de basura)
        function borrarItem(indice) {
            // Borra 1 elemento en la posición "indice"
            carrito.splice(indice, 1);
            guardarYActualizar();

            // Si vació el carrito, cerramos el modal, sino recargamos la lista
            if (carrito.length === 0) {
                cerrarResumen();
            } else {
                abrirResumen(); // Volvemos a dibujar la lista actualizada
            }
        }

        // D. FINALIZAR: ARMAR EL LINK DE WHATSAPP
        // Carga automática de datos si ya compró antes
        window.onload = function () {
            if (localStorage.getItem('clienteNombre')) {
                document.getElementById('txtClienteNombre').value = localStorage.getItem('clienteNombre');
            }
            if (localStorage.getItem('clienteDireccion')) {
                document.getElementById('txtClienteDireccion').value = localStorage.getItem('clienteDireccion');
            }
        };

        function confirmarYEnviar() {
            // 1. CAPTURAMOS LOS DATOS DEL FORMULARIO
            const nombre = document.getElementById('txtClienteNombre').value.trim();
            const direccion = document.getElementById('txtClienteDireccion').value.trim();
            const aclaraciones = document.getElementById('txtAclaraciones').value.trim();

            // 2. VALIDACIÓN BÁSICA (Que no manden vacío)
            if (nombre === "" || direccion === "") {
                alert("⚠️ Por favor, completá tu nombre y dirección para el envío.");
                return; // Cortamos acá, no se manda nada.
            }

            // 3. GUARDAMOS LOS DATOS PARA LA PRÓXIMA (UX PRO)
            localStorage.setItem('clienteNombre', nombre);
            localStorage.setItem('clienteDireccion', direccion);

            // 4. ARMAMOS EL MENSAJE
            const telefonoNegocio = "5491112345678"; // <--- TU NÚMERO

            let mensaje = `Hola! Soy *${nombre}*. Quiero hacer el siguiente pedido:%0A%0A`;

            carrito.forEach(prod => {
                mensaje += `▪️ ${prod.nombre} ($${prod.precio})%0A`;
            });

            const total = carrito.reduce((suma, prod) => suma + prod.precio, 0);
            mensaje += `%0A*TOTAL A PAGAR: $${total}*`;

            mensaje += `%0A%0A📍 *Dirección de envío:*%0A${direccion}`;

            if (aclaraciones !== "") {
                mensaje += `%0A📝 *Nota:* ${aclaraciones}`;
            }

            // 5. ENVIAMOS
            window.open("https://wa.me/" + telefonoNegocio + "?text=" + mensaje, '_blank');

            // Opcional: Cerrar modal y limpiar carrito
            // carrito = [];
            // localStorage.setItem('miCarrito', JSON.stringify(carrito));
            // cerrarResumen();
            // actualizarBotonFlotante();
        }
    </script>
</body>
</html>
