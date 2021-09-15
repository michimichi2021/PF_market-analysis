class Public::HomesController < ApplicationController
  
  def top
    @items_new=Item.page(params[:page]).per(8)
    @current_time = Time.current
    @items=Item.all
    @genre_list=Genre.all
  end
  
end
