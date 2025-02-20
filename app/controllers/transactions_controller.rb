require "mercadopago"

class TransactionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_order, only: %i[new create]

  def new
    @transaction = Transaction.new
  end
  def show
    @transaction = Transaction.find(params[:id])
  end

  def create
    sdk = Mercadopago::SDK.new(Rails.application.credentials.mercadopago.access_token)
    custom_headers = { 'x-idempotency-key': "#{@order.id}_#{@order.transactions.count}" }
    request_options = Mercadopago::RequestOptions.new(custom_headers:)
    @transaction = Transaction.new(order: @order, **transaction_params)
    @transaction.prepayment_data[:transaction_amount] = @order.total_price

    @transaction.payment_data = sdk.payment.create(@transaction.prepayment_data, request_options:)
    @transaction.save
    #redirect_to transaction.order
  end

  private

  def set_order
    @order = Order.find(params[:order_id])
  end

  def transaction_params
    params.require(:transaction).permit(prepayment_data: [
      :token,
      :payment_method_id,
      :installments,
      :issuer_id,
      :description,
      payer: [
        :email,
        { identification: [:type, :number] }
      ]]
    )
  end

end
