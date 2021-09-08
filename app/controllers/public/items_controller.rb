class Public::ItemsController < ApplicationController
  
  def new
    @item=Item.new
  end
  
  def create
    @item = current_user.items.new(item_params)           
    genre_list = params[:item][:genre_ids].split(',')  
    if @item.save                                         
      @item.save_genre(genre_list) 
       redirect_to item_path(@item) 
    else
      render 'new'
    end
  end
  
  def show
    @item = Item.find(params[:id]) 
    @item_genres = @item.genres 
    @purchase=Purchase.new
    @comment=Comment.new
    @user=@item.user
  end
  
  def edit
   @item =Item.find(params[:id])
   @genre_list =@item.genres.pluck(:name).join(",")
  end
  
  def update
    @item=Item.find(params[:id])
    genre_list = params[:item][:genre_ids].split(',')  
    if @item.update(item_params)
      @item.save_genre(genre_list)
      redirect_to item_path(@item) 
    else
      render 'edit'
    end
  end
  
 
  
  def item_params
    params.require(:item).permit(:image, :name, :introduction, :price, :shipping_fee, :shipping_method, :shipping_area, :preparation_day)
  end
  
end
