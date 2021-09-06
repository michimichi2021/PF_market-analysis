class Public::ItemsController < ApplicationController
  
  def new
    @item=Item.new
  end
  
  def create
    @item.new(item_params)
    if @item.save
    redirect_to item_path(@item) 
    else
      render 'new'
    end
  end
  
  def show
    @item=Item.find(params[:id])
  end
  
  def edit
    @item=Item.find(params[:id])
  end
  
  def update
    @item=Item.find(params[:id])
    if @item.update(item_params)
     redirect_to item_path(@item) 
    else
      render 'edit'
    end
  end
  
  def item_params
    params.require(:item).permit(:image, :genre_id, :name, :introduction, :price, :shipping_fee, :shipping_method, :shipping_area, :preparation_day)
  end
  
end
