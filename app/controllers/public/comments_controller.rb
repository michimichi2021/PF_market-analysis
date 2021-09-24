class Public::CommentsController < ApplicationController
  def create
    @item = Item.find(params[:item_id])
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.item_id = @item.id
    @comments = @item.comments
    @comment.save
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @item = Item.find(params[:item_id])
    @comments = @item.comments
    @comment = Comment.find_by(id: params[:id], item_id: params[:item_id])
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :item_id, :user_id)
  end
end
