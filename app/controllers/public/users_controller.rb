class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
     @user=User.find(params[:id])
     @items=@user.items
     @item=Item.find(params[:id])
  end
  
  def edit
    @user =User.find(params[:id])
  end
  
  def update
    @user=User.find(params[:id])
    if @user.update(user_params)
     redirect_to user_path(@user)
    else
     render 'edit'
    end
  end
  
  def unsubscribe
    @user=current_user
  end
  
  def withdraw
    @user=current_user
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end
  
  def favorites
    @user = User.find(params[:id])
    favorites= Favorite.where(user_id: @user.id).pluck(:item_id)
    @favorite_items = Item.find(favorites)
  end
  
  private
  
  def user_params
   params.require(:user).permit(:name, :profile, :is_deleted, :image, :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email, :encrypted_password)
  end

end
