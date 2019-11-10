class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_billboard

  def new
    @comment = Comment.new
  end

  def create
    @comment = @billboard.comments.create(comment_params)
    @comment.nickname =  current_user.nickname
    respond_to do |format|
      if @comment.save
        format.js
      end
    end
  end


  private

  def set_billboard
    @billboard = Billboard.find(params[:billboard_id])
  end

  def comment_params
    params.require(:comment).permit(:nickname,
                                    :body)
  end
end