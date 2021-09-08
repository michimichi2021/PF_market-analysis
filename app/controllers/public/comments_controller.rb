class Public::CommentsController < ApplicationController
  
  def create
    item = Item.find(params[:item_id])
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    comment.item_id = item.id
    comment.save
    redirect_to item_path(item)
  end
  
  def destroy
    Comment.find_by(id: params[:id], item_id: params[:item_id]).destroy
    redirect_to item_path(params[:item_id])
  end
  
  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
  
end
