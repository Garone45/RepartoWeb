<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Catalogo.aspx.cs" Inherits="VerduleriaWeb.Catalogo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Lista de Precios - Verdulería</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <style>/* ESTILOS DEL MODAL (VENTANA EMERGENTE) */
.modal-overlay {
    position: fixed;
    top: 0; left: 0;
    width: 100%; height: 100%;
    background-color: rgba(0,0,0,0.5); /* Fondo negro semitransparente */
    z-index: 2000; /* Por encima de todo */
    display: flex;
    justify-content: center;
    align-items: center;
}
/* Agregalo en tu <style> */
.input-datos {
    width: 100%;
    padding: 10px;
    margin-bottom: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-family: inherit;
    box-sizing: border-box; /* Para que no se salga del ancho */
}
.col-nombre {
    max-width: 180px; /* Le ponemos un límite */
    white-space: normal; /* Que baje al renglón de abajo si es largo */
    word-wrap: break-word; 
}   

.modal-caja {
    background-color: white;
    width: 90%;
    max-width: 500px; /* Que no sea gigante en PC */
    border-radius: 15px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.3);
    overflow: hidden;
    animation: aparecer 0.3s ease-out;
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

.modal-header h2 { margin: 0; font-size: 1.2rem; }

.cerrar-modal {
    font-size: 1.5rem;
    cursor: pointer;
    font-weight: bold;
}

.modal-body {
    max-height: 60vh; /* Si es muy larga la lista, hace scroll */
    overflow-y: auto;
    padding: 15px;
}

/* CADA RENGLÓN DEL RESUMEN */
.item-resumen {
    display: flex;
    justify-content: space-between;
    padding: 10px 0;
    border-bottom: 1px solid #eee;
    align-items: center;
}

.btn-borrar {
    color: #ff4444;
    cursor: pointer;
    font-weight: bold;
    margin-left: 10px;
    background: none;
    border: none;
    font-size: 1.2rem;
}

.modal-footer {
    padding: 15px;
    background-color: #f9f9f9;
    border-top: 1px solid #eee;
    text-align: center;
}

.total-final {
    font-size: 1.5rem;
    font-weight: bold;
    color: #2e7d32;
    margin-bottom: 15px;
}

.btn-whatsapp-final {
    background-color: #25D366;
    color: white;
    border: none;
    padding: 12px 30px;
    font-size: 1.1rem;
    border-radius: 50px;
    cursor: pointer;
    width: 100%;
}
.btn-whatsapp-final:hover { background-color: #128C7E; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #fff; margin: 0; padding: 0; }
        
        .header { background-color: #2e7d32; color: white; padding: 15px; text-align: center; }
        .header h1 { margin: 0; font-size: 1.5rem; }

        /* ESTILO DE LA TABLA (MODO LISTA) */
        .contenedor-lista {
            max-width: 800px;
            margin: 20px auto;
            padding: 0 10px;
        }


        table {
            width: 100%;
            border-collapse: collapse; /* Para que no haya espacios entre celdas */
            background-color: white;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        th { background-color: #f1f1f1; text-align: left; padding: 12px; border-bottom: 2px solid #ddd; }
        
        /* Filas de productos */
        td { padding: 12px; border-bottom: 1px solid #eee; vertical-align: middle; }
        
        /* Efecto cebra (una gris, una blanca) para leer mejor */
        tr:nth-child(even) { background-color: #f9f9f9; } 
        
        /* Columnas específicas */
        .col-precio { font-weight: bold; color: #2e7d32; white-space: nowrap; }
        .col-accion { text-align: right; }

        /* EL BOTÓN DE AGREGAR (+) */
        .btn-add {
            /* ... lo que ya tenías ... */
            width: 45px; /* Antes 35px */
            height: 45px; /* Antes 35px */
            font-size: 1.5rem; /* El signo + más grande */
            margin-left: 5px;
        }

        .btn-add:hover {
            background-color: #2e7d32;
            color: white;
        }

        .btn-add:active { transform: scale(0.9); }

        /* ETIQUETA DE CATEGORÍA CHICA */
        .badge {
            background-color: #e8f5e9;
            color: #2e7d32;
            padding: 2px 6px;
            border-radius: 4px;
            font-size: 0.75rem;
            text-transform: uppercase;
            font-weight: bold;
        }
        
        .nombre-prod { font-size: 1rem; display: block; }
        .desc-prod { font-size: 0.8rem; color: #777; }

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
           style="width: 100%; padding: 12px; font-size: 1rem; border: 1px solid #ddd; border-radius: 8px; box-sizing: border-box;"/>
</div>

            <table>
                <thead>
                    <tr>
                        <th>Producto</th>
                        <th>Precio</th>
                        <th style="text-align:right;">Agregar</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="repProductos" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <span class="badge"><%# Eval("Categoria.Nombre") %></span>
                                    <span class="nombre-prod"><%# Eval("Nombre") %></span>
                                    <span class="desc-prod"><%# Eval("Descripcion") %></span>
                                </td>

                                <td class="col-precio">
                                    $<%# Eval("Precio") %> 
                                    <span style="font-weight:normal; font-size:0.8em; color:#666;">/ <%# Eval("Unidad") %></span>
                                </td>

                                <td class="col-nombre">
                                    <button type="button" class="btn-add" onclick="agregarAlCarrito('<%# Eval("Nombre") %>', <%# Eval("Precio") %>)">
                                        +
                                    </button>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>

            </table>
        </div>

        <div style="height: 100px;"></div>

        <div id="btn-flotante" onclick="abrirResumen()" style="display:none; position: fixed; bottom: 20px; right: 20px; background-color: #25D366; color: white; padding: 15px 25px; border-radius: 50px; box-shadow: 0 4px 10px rgba(0,0,0,0.3); cursor: pointer; font-size: 1.2rem; align-items: center;">
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
            <h4 style="margin-top:0; color:#2e7d32;">📍 Datos de Envío</h4>
            
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