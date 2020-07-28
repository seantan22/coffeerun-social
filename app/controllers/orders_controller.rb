class OrdersController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :update]
  
  def create
    @order = current_user.orders.build(order_params_new)
    if @order.save
      flash[:success] = "Order created!"
      redirect_to root_url
    else
      @feed_items = current_user.order_feed.paginate(page: params[:page], per_page: 10)
      render 'static_pages/home'
    end
  end
  
  def edit
    @order = Order.find(params[:id])
  end
  
  def update
    @order = Order.find(params[:id])
    if @order.update(order_params_update)
      redirect_back(fallback_location: root_path)
      flash[:success] = "Status updated!"
    else
      render 'edit'
    end
  end
  
  def destroy
  end
  
  private
  
  def order_params_new
    params.require(:order).permit(:vendor, :item, :size, :details, :zone)
  end
  
  def order_params_update
    params.permit(:status)
  end
  
end