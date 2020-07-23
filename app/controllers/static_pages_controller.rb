class StaticPagesController < ApplicationController
  
  def home
    if logged_in?
      @order = current_user.orders.build
      @feed_items = current_user.feed.paginate(page: params[:page], per_page: 5)
    end
  end
  
  def about
  end
  
  def contact
  end
  
end
