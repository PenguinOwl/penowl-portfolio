require 'tree_builder'
require 'markdown'

class CommentsController < ApplicationController

  before_action except: [:index, :show] do
    authenticate_user!
    @is_mod = check_user_flag "admin", "mod"
  end

  def create
    @root_comment = Comment.find comment_params[:comment_id]
    @comment = @root_comment.replies.create comment_params
    up = @comment
    while (up = Comment.find up.comment_id).comment_id
    end
    redirect_to up
  end

  def create_root
    @comment = Comment.create comment_params
    redirect_to @comment
  end

  def index
    @comments = Comment.all.sort_by {|e| e.created_at}
    @comments = @comments.select { |item| !item.comment_id}
  end

  def show
    @comment = Comment.find(params[:id])
    @renderer = Redcarpet::Markdown.new(MarkdownRenderer, no_intra_emphasis: true, autolink: true, fenced_code_blocks: true, disable_indented_code_blocks: true)
    @tree = TreeBuilder.new(@comment)
    @tree.render
  end

  def new
    respond_to do |format|
      format.html
      format.js
    end
    @comment = Comment.new
    @root_comment = Comment.find params[:comment_id]
  end

  def root_new
    @comment = Comment.new
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
      up = @comment
      unless up.comment_id
        redirect_to up
      else
        while (up = Comment.find up.comment_id).comment_id
        end
        redirect_to up
      end
    else
      render 'edit'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    to_redirect = @comment.comment_id
    @comment.destroy
    if to_redirect
      redirect_to Comment.find(to_redirect)
    else
      redirect_to comments_path
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :content, :comment_id, :title)
  end
end
