class Admin::SearchesController < ApplicationController
 before_action :authenticate_admin!
  
  def search
    word = params[:search_word]
    @users = User.search(word)
  end
  
end