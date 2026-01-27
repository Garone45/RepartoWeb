using System;
using System.Collections.Generic;
using MercadoPago.Client.Preference;
using MercadoPago.Config;
using MercadoPago.Resource.Preference;

namespace Negocio  // <--- IMPORTANTE: Que diga el nombre de tu proyecto de lógica
{
    public class MercadoPagoService
    {
        public MercadoPagoService()
        {
            // PEGÁ TU TOKEN "APP_USR-..." ACÁ
            MercadoPagoConfig.AccessToken = "APP_USR-8818390291937407-012616-3813f05551789478a404514ea2e00213-3160583463";
        }

        public string CrearPreferencia(string nombreCliente, decimal total, int idPedido)
        {
            // ... (El resto del código es IGUAL al que te pasé antes)

            var item = new PreferenceItemRequest
            {
                Title = "Pedido #" + idPedido + " - Reparto Web",
                Quantity = 1,
                CurrencyId = "ARS",
                UnitPrice = total
            };

            var backUrls = new PreferenceBackUrlsRequest
            {
                Success = "https://www.google.com.ar",
                Failure = "https://www.google.com.ar",
                Pending = "https://www.google.com.ar"
            };

            var request = new PreferenceRequest
            {
                Items = new List<PreferenceItemRequest> { item },
                BackUrls = backUrls,
                AutoReturn = "approved",
                ExternalReference = idPedido.ToString()
            };

            var client = new PreferenceClient();
            Preference preference = client.Create(request);

            return preference.InitPoint;
        }
    }
}   