class Public::PurchasesController < ApplicationController
  
  def new
    @purchase=Purchase.new
    @item=Item.find(params[:purchase][:item_id])
  end
  
  def confirm
    @purchase = Purchase.new(purchase_params)
    @purchase.user_id = current_user.id
    @item=Item.find(@purchase.item_id)
    # @item=current_user.purchase.item
    # @purchase.item_id=@item.id
    
    if params[:shipping_address]=="0" 
          @shipping_postcode=current_user.postal_code
          @shipping_address= current_user.address
          @shipping_name= current_user.last_name+""+current_user.first_name
    
    else  params[:shipping_address]=="1" 
          @shipping_postcode= @purchase.postal_code
          @shipping_address= @purchase.address
          @shipping_name= @purchase.name
    end
  end
  
  def create
   @purchase=Purchase.new(purchase_params)
   @purchase.user_id = current_user.id
   @item=Item.find(@purchase.item_id)
    if @purchase.save
  
    redirect_to purchases_path
    else
    render 'new'  
    end
  end
  
  def index
      @purchases = current_user.purchases
  end
  
  def show
  end
  
  private
  
  def purchase_params
     params.require(:purchase).permit(:user_id, :postal_code, :address, :name, :payment_method, :item_id)
  end
  
end
