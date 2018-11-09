require 'tree_builder'

class CommentsController < ApplicationController
  def create
    if comment_params[:comment_id]
      @root_comment = Comment.find comment_params[:comment_id]
      @comment = @root_comment.replies.create comment_params
      redirect_to CommentThread.find @root_comment.comment_thread_id
    else
      @comment_thread = CommentThread.find comment_params[:comment_thread_id]
      @comment = @comment_thread.comments.create comment_params
      redirect_to @comment_thread
    end
  end

  def new
    respond_to do |format|
      format.html
      format.js
    end
    @comment = Comment.new
    @root_comment = Comment.find params[:comment][:comment_id] if params[:comment]
    @comment_thread = CommentThread.find params[:comment_thread_id]
  end

  def edit
    respond_to do |format|
      format.html
      format.js
    end
    @comment = Comment.find(params[:comment_id])
  end

  def predestroy
    respond_to do |format|
      format.html
      format.js
    end
    @comment = Comment.find(params[:comment_id])
  end

  def update
    @comment = Comment.find(params[:comment_id])

    if @comment.update(comment_params)
      redirect_to @comment.comment_thread
    else
      render 'edit'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to comment_thread_path
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :content, :comment_thread_id, :comment_id)
  end
end
