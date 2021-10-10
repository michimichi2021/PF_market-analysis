class Public::FavoritesController < ApplicationController
  def create
    @item = Item.find(params[:item_id])
    favorite = current_user.favorites.new(item_id: @item.id)
    favorite.save
    @item.create_notification_by(current_user)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @item = Item.find(params[:item_id])
    favorite = current_user.favorites.find_by(item_id: @item.id)
    favorite.destroy
    respond_to do |format|
      format.js
    end
  end
end
