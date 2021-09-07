class Admin::SearchesController < ApplicationController
  
  def search
    word = params[:search_word]
    @users = User.search(word)
  end
  
end