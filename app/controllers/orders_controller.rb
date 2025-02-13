class OrdersController < ApplicationController
  before_action :set_order, only: %i[edit update]

  def create
    @menu = Menu.find(params[:menu_id])
    @order = Order.new(**order_params, user: current_user, menu: @menu)
    if @order.save
      @order.item_orders.each { it.update price: it.item.price }
      redirect_to edit_order_path(@order)
    else
      render "menus/show", status: :unprocessable_entity
    end
  end

  def edit

  end

  def update
    if @order.update(order_params)
      redirect_to edit_order_path(@order) # pay....
    else
      render edit_order_path(@order), status: :unprocessable_entity
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def set_menu
    @menu = Menu.find(params[:menu_id])
  end

  def order_params
    params.require(:order).permit(
      item_orders_attributes: [
        :id, :item_id, :quantity, :_destroy
      ]
    )
  end
end
