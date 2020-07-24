class StaticPagesController < ApplicationController
  
  def home
    if logged_in?
      @order = current_user.orders.build
      @feed_items = current_user.order_feed.paginate(page: params[:page], per_page: 5)
    end
  end
  
  def about
  end
  
  def contact
  end
  
  def feed
    if logged_in?
      @social_feed_items = current_user.social_feed.paginate(page: params[:page], per_page: 10)
    end
  end
  
end
