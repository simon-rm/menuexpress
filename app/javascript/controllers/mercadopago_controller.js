import { Controller } from "@hotwired/stimulus";
import { loadMercadoPago } from "@mercadopago/sdk-js";

// Connects to data-controller="mercadopago"
export default class extends Controller {
  static values = {
    price: String,
    pk: String,
  }
  async connect() {
    await loadMercadoPago();
    const mp = new window.MercadoPago(this.pkValue);
    const form = document.querySelector("#form-checkout");

    const cardForm = mp.cardForm({
      amount: this.priceValue,
      iframe: true,
      form: {
        id: "form-checkout",
        cardNumber: {
          id: "form-checkout__cardNumber",
          placeholder: "Card Number",
        },
        expirationDate: {
          id: "form-checkout__expirationDate",
          placeholder: "MM/YY",
        },
        securityCode: {
          id: "form-checkout__securityCode",
          placeholder: "Security Code",
        },
        cardholderName: {
          id: "form-checkout__cardholderName",
          placeholder: "Cardholder",
        },
        issuer: {
          id: "form-checkout__issuer",
          placeholder: "Issuing bank",
        },
        installments: {
          id: "form-checkout__installments",
          placeholder: "Installments",
        },
        identificationType: {
          id: "form-checkout__identificationType",
          placeholder: "Document type",
        },
        identificationNumber: {
          id: "form-checkout__identificationNumber",
          placeholder: "Document number",
        },
        cardholderEmail: {
          id: "form-checkout__cardholderEmail",
          placeholder: "Email",
        },
      },
      callbacks: {
        onFormMounted: error => {
          if (error) return console.warn("Form Mounted handling error: ", error);
          console.log("Form mounted");
        },
        onSubmit: event => {
          event.preventDefault();

          const {
            paymentMethodId: payment_method_id,
            issuerId: issuer_id,
            cardholderEmail: email,
            token,
            installments,
            identificationNumber,
            identificationType,
          } = cardForm.getCardFormData();

          fetch(form.action, {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
            },
            body: JSON.stringify({
              transaction: {
                prepayment_data: {
                  token,
                  issuer_id,
                  payment_method_id,
                  installments: Number(installments),
                  description: "Product Description",
                  payer: {
                    email,
                    identification: {
                      type: identificationType,
                      number: identificationNumber,
                    },
                  },
                }
              }
            }),
          });
        },
        onFetching: (resource) => {
          console.log("Fetching resource: ", resource);

// Animate progress bar
          const progressBar = document.querySelector(".progress-bar");
          progressBar.removeAttribute("value");

          return() => {
            progressBar.setAttribute("value", "0");
          };
        }
      },
    });

  }
}
