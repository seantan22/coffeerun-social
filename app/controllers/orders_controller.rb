class OrdersController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  
  def create
    @order = current_user.orders.build(order_params)
    if @order.save
      flash[:success] = "Order created!"
      redirect_to root_url
    else
      @feed_items = current_user.order_feed.paginate(page: params[:page], per_page: 10)
      render 'static_pages/home'
    end
  end
  
  def destroy
  end
  
  private
  
  def order_params
    params.require(:order).permit(:item, :details, :vendor, :zone, :size)
  end
  
end