class Public::UsersController < ApplicationController
  before_action :authenticate_user!

  def show
     @user=User.find(params[:id])
     @items = @user.items.page(params[:page]).reverse_order
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

  def datas
    @items=current_user.items.purchased
    @sum=@items.sum(:price)
    
    @items_price_day = @items.group_by_day(:created_at).sum(:price)
    @items_price_week = @items.group_by_week(:created_at, week_start: :monday).sum(:price)
    @items_price_month = @items.group_by_month(:created_at).sum(:price)
    @item_purchase_genre_count= current_user.items.joins(:genres).where(is_active: false).group('genres.name').size
  end

  private

  def user_params
   params.require(:user).permit(:name, :profile, :is_deleted, :image, :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email, :encrypted_password)
  end

end
