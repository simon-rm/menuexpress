class MenusController < ApplicationController
  before_action :set_menu, only: %i[show edit update destroy]

  # GET /menus
  def index
    @menus = Menu.all
  end

  # GET /menus/:id
  def show
    if current_user.pending_order.nil?
      @order_items = @menu.items.map { OrderItem.new(item_id: it.id) }
    elsif current_user.pending_order.menu == @menu
      selected_order_items = current_user.pending_order.order_items
      unselected_items = @menu.items.reject do
        it.id.in? selected_order_items.pluck(:item_id)
      end
      unselected_order_items = unselected_items.map { OrderItem.new(item_id: it.id) }
      @order_items = selected_order_items + unselected_order_items
      @total_price = selected_order_items.sum("price * quantity")
    end
  end

  # GET /menus/new
  def new
    @menu = Menu.new
  end

  # POST /menus
  def create
    @menu = Menu.new(**menu_params, user: current_user)
    if @menu.save
      redirect_to @menu, notice: "Menu was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /menus/:id/edit
  def edit
  end

  # PATCH/PUT /menus/:id
  def update
    if @menu.update(menu_params)
      redirect_to @menu, notice: "Menu was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /menus/:id
  def destroy
    @menu.destroy
    redirect_to menus_url, notice: "Menu was successfully deleted."
  end

  private

  def set_menu
    @menu = Menu.find(params[:id])
  end

  def menu_params
    params.require(:menu).permit(
      :name,
      categories_attributes: [
        :id, :name, :_destroy,
        items_attributes: [:id, :name, :description, :price, :_destroy]
      ]
    )
  end
end
