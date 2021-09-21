class Public::HomesController < ApplicationController
  
  def top
    @items_new=Item.page(params[:page]).per(8)
    @current_time = Time.current
    @items=Item.page(params[:page]).per(12)
  end
  
end
