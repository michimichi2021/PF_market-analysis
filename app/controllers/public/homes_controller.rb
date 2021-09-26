class Public::HomesController < ApplicationController
  def top
    @items_new = Item.order('id DESC').limit(5)
    @items = Item.page(params[:page]).per(12).reverse_order
  end
end
