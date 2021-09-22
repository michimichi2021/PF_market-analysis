class Public::HomesController < ApplicationController
  def top
    @items_new = Item.order('id DESC').limit(8)
    @items = Item.page(params[:page]).per(12)
  end
end
