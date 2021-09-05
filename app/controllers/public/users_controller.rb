class Public::UsersController < ApplicationController
  
  def show
    @user = current_user
  end
  
  def edit
    @user = current_user
  end
  
  
  private
  
  def user_params
   
  end
end
