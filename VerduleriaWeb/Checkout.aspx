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
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
        
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
              <label>Teléfono (WhatsApp)</label>
              <input type="tel" id="txtTelefono" placeholder="Ej: 1123456789" required />
          </div>

          <div class="grupo-form">
              <label>Zona de Entrega</label>
              <select id="ddlZona" required style="width: 100%; padding: 12px 15px; border: 1.5px solid #eee; border-radius: 12px; font-family: 'Poppins', sans-serif; font-size: 1rem; box-sizing: border-box;">
                  <option value="" disabled selected>Seleccioná tu localidad...</option>
                  <option value="San Fernando">San Fernando</option>
                  <option value="Tigre">Tigre</option>
                  <option value="San Isidro">San Isidro</option>
                  <option value="Beccar">Beccar</option>
                  <option value="Martinez">Martínez</option>
              </select>
          </div>

          <div class="grupo-form">
              <label>Dirección de Entrega</label>
              <input type="text" id="txtDireccion" placeholder="Ej: Av. Cazón 1234, Depto 4B" required />
          </div>

        <div class="grupo-form">
              <label>Día de Entrega</label>
              <select id="txtFechaEntrega" required style="width: 100%; padding: 12px 15px; border: 1.5px solid #eee; border-radius: 12px; font-family: 'Poppins', sans-serif; font-size: 1rem; box-sizing: border-box;">
                  </select>
              <small style="color: #666; font-size: 0.8rem; display: block; margin-top: 5px;">* Repartimos los Miércoles, Viernes y Sábados.</small>
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
      // 1. Al cargar la página, inicializamos todo
      window.onload = function () {
          renderizarCarrito();
          cargarFechasEntrega();
      }

      // 2. Función para dibujar el carrito y calcular el total
      function renderizarCarrito() {
          let carrito = JSON.parse(localStorage.getItem('miCarrito')) || [];
          let contenedorLista = document.getElementById('listaCheckout');
          let totalPedido = 0;

          if (carrito.length === 0) {
              contenedorLista.innerHTML = "<p style='color:red; font-weight:bold; text-align:center;'>Tu carrito está vacío. 🛒</p>";
              document.getElementById('lblTotalCheckout').innerText = "$0";
              return;
          }

          contenedorLista.innerHTML = "";
          carrito.forEach((item, index) => {
              contenedorLista.innerHTML += `
                <div class="item-carrito" style="display:flex; justify-content:space-between; align-items:center; margin-bottom: 12px; border-bottom: 1px solid #eee; padding-bottom: 8px;">
                    <div style="display:flex; flex-direction:column;">
                        <span style="font-weight:600; font-size:0.95rem;">${item.cantidad || 1}x ${item.nombre}</span>
                        <span style="color:#2e7d32; font-weight:700;">$${item.precio}</span>
                    </div>
                    <button onclick="eliminarItem(${index})" style="background:none; border:none; color:#e63946; font-size:1.2rem; cursor:pointer; padding:5px;">🗑️</button>
                </div>
            `;
              totalPedido += item.precio;
          });

          document.getElementById('lblTotalCheckout').innerText = "$" + totalPedido;
      }

      // 3. Función para borrar un ítem específico
      function eliminarItem(index) {
          let carrito = JSON.parse(localStorage.getItem('miCarrito')) || [];
          carrito.splice(index, 1); // Borramos el seleccionado
          localStorage.setItem('miCarrito', JSON.stringify(carrito)); // Guardamos cambios
          renderizarCarrito(); // Refrescamos la vista y el total
      }

      // 4. Cargamos el selector de fechas (Miércoles, Viernes y Sábados)
      function cargarFechasEntrega() {
          let selectFecha = document.getElementById('txtFechaEntrega');
          if (!selectFecha) return;

          selectFecha.innerHTML = '<option value="" disabled selected>Elegí un día de reparto...</option>';

          let diasNombres = ["Domingo", "Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado"];
          let fechaIterador = new Date();
          fechaIterador.setDate(fechaIterador.getDate() + 1); // Empezamos a buscar desde mañana

          let diasEncontrados = 0;
          while (diasEncontrados < 5) { // Mostramos las próximas 5 fechas válidas
              let diaSemana = fechaIterador.getDay();

              // 3: Miércoles, 5: Viernes, 6: Sábado
              if (diaSemana === 3 || diaSemana === 5 || diaSemana === 6) {
                  let diaNum = String(fechaIterador.getDate()).padStart(2, '0');
                  let mesNum = String(fechaIterador.getMonth() + 1).padStart(2, '0');
                  let anioNum = fechaIterador.getFullYear();

                  let valorFecha = `${diaNum}/${mesNum}/${anioNum}`;
                  let textoMostrar = `${diasNombres[diaSemana]} ${diaNum}/${mesNum}`;

                  let opt = document.createElement('option');
                  opt.value = valorFecha;
                  opt.text = textoMostrar;
                  selectFecha.appendChild(opt);

                  diasEncontrados++;
              }
              fechaIterador.setDate(fechaIterador.getDate() + 1);
          }
      }

      // 5. Función principal para enviar el pedido
      function enviarPedido() {
          const nombre = document.getElementById("txtNombre").value;
          const zona = document.getElementById("ddlZona").value;
          const direccion = document.getElementById("txtDireccion").value;
          const telefono = document.getElementById("txtTelefono").value;
          const fechaLegible = document.getElementById("txtFechaEntrega").value;
          const totalTexto = document.getElementById('lblTotalCheckout').innerText.replace('$', '');

          // Validación de campos
          if (!nombre || !zona || !direccion || !telefono || !fechaLegible) {
              alert("Por favor, completá todos tus datos para organizar el envío. 🚚");
              return;
          }

          const totalNum = parseFloat(totalTexto);
          if (totalNum <= 0) {
              alert("Tu carrito está vacío.");
              return;
          }

          // Llamada al servidor (C# WebMethod)
          // Pasamos los 6 parámetros: nombre, zona, direccion, telefono, fecha, total
          PageMethods.GuardarPedido(nombre, zona, direccion, telefono, fechaLegible, totalNum,
              function (resultado) {
                  if (resultado) {
                      // Armamos el mensaje para WhatsApp
                      const mensaje = `Hola Salvador! 🥦 Te hago un pedido:\n\n👤 Nombre: ${nombre}\n📍 Zona: ${zona}\n🏠 Dirección: ${direccion}\n📅 Día de entrega: ${fechaLegible}\n\n💰 Total: $${totalTexto}`;

                      const url = `https://wa.me/5491138517333?text=${encodeURIComponent(mensaje)}`;
                      window.open(url, '_blank');

                      // LIMPIEZA FINAL
                      localStorage.removeItem('miCarrito'); // Vaciamos el carrito
                      alert("¡Pedido enviado con éxito! 🥦");
                      window.location.href = "Inicio.aspx"; // Volvemos al inicio
                  } else {
                      alert("Hubo un error al guardar el pedido en el servidor.");
                  }
              },
              function (error) {
                  console.log(error);
                  alert("Error de conexión con el servidor. Revisá los datos.");
              }
          );
      }
  </script>
</body>
</html>