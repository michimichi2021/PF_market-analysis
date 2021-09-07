class Public::HomesController < ApplicationController
  
  def top
    @items=Item.all
    @genre_list=Genre.all
  end
  
end
