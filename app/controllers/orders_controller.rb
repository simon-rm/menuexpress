class OrdersController < ApplicationController
  def edit
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    @total_price = @order_items.sum("price * quantity")
  end
end
