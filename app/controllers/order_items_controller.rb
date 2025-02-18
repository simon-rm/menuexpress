class OrderItemsController < ApplicationController
  before_action :set_order_item, only: %i[update destroy]

  def create
    item = Item.find(order_item_params[:item_id])
    order = current_user.orders.pending.find_or_create_by(menu: item.menu)
    order.order_items.create!(**order_item_params, price: item.price)
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
