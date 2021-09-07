class Public::SearchesController < ApplicationController
 def search_tag
    @genre=Genre.find(params[:genre_id])
    @items=@genre.items.all
 end
  
  def tag_lists
    @genre_list=Genre.all
  end
  
  def search
    word = params[:search_word]
    @items = Item.search(word)
  end
  
end