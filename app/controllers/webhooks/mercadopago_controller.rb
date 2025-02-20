class Webhooks::MercadopagoController < ApplicationController
  skip_before_action :verify_authenticity_token # Webhooks are external requests

  def receive
    event = request.raw_post # Get raw JSON payload
    data = JSON.parse(event) rescue {}

    # Log the event for debugging (optional)
    Rails.logger.info "MercadoPago Webhook received: #{data}"

    # Handle the event based on its type
    case data["type"]
    when "payment"
      process_payment(data["data"]["id"])
    else
      Rails.logger.warn "Unhandled event type: #{data["type"]}"
    end

    head :ok
  end

  private

  def process_payment(payment_id)
    # Fetch payment details from Mercado Pago API
    payment = MercadoPago::Payment.find(payment_id) rescue nil
    return unless payment

    # Handle payment status
    case payment.status
    when "approved"
      Rails.logger.info "Payment #{payment_id} approved."
      # Update order status, notify user, etc.
    when "rejected"
      Rails.logger.info "Payment #{payment_id} rejected."
      # Handle rejection logic
    else
      Rails.logger.info "Payment #{payment_id} status: #{payment.status}."
    end
  end
end