class Public::SearchesController < ApplicationController
  def search_tag
    @genre = Genre.find(params[:genre_id])
    @items = @genre.items.page(params[:page]).per(6)
  end

  def tag_lists
    @genre_list = Genre.page(params[:page]).per(20)
    @tag_ranks = Genre.find(Tag.group(:genre_id).order('count(genre_id)desc').limit(10).pluck(:genre_id))
  end

  def search
    @word = params[:search_word]
    @items = Item.search(@word).page(params[:page]).per(6)
  end
end
