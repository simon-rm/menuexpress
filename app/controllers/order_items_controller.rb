class OrderItemsController < ApplicationController
  before_action :set_order_item, only: %i[update destroy]

  def index
    @order = current_user.pending_order
    @order_items = @order.order_items
    @total_price = @order_items.sum("price * quantity")
  end

  def create
    item = Item.find(order_item_params[:item_id])
    pending_order = current_user.pending_order
    if pending_order.nil? || pending_order.menu == item.menu
      order = pending_order || Order.create!(user: current_user)
      OrderItem.create!(**order_item_params, order:, price: item.price)
    end
    redirect_back_or_to :root
  end

  def update
    @order_item.update(order_item_params)
    redirect_back_or_to :root
  end

  def destroy
    order = @order_item.order
    if order.items.one?
      order.destroy
      redirect_to @order_item.menu
    else
      @order_item.destroy
      redirect_back_or_to :root
    end
  end

  private

  def set_order_item
    @order_item = OrderItem.find(params[:id])
  end

  def order_item_params
    params.require(:order_item).permit(:item_id, :quantity)
  end
end
