require "markdown"
require "tree_builder"

class CommentThreadsController < ApplicationController
  before_action except: [:index, :show] do
    authenticate_user!
    @is_mod = check_user_flag "admin", "mod"
  end

  def index
    @comment_threads = CommentThread.all.sort_by {|e| e.created_at}
  end

  def show
    @comment_thread = CommentThread.find(params[:id])
    @renderer = Redcarpet::Markdown.new(MarkdownRenderer, no_intra_emphasis: true, autolink: true, fenced_code_blocks: true, disable_indented_code_blocks: true)
    @tree = TreeBuilder.new(@comment_thread)
    @tree.render
  end

  def new
    @comment_thread = CommentThread.new
  end

  def edit
    @comment_thread = CommentThread.find(params[:id])
  end

  def update
    @comment_thread = CommentThread.find(params[:id])

    if @comment_thread.update(comment_thread_params)
      redirect_to @comment
      render 'edit'
    end
  end

  def create
    updated_parms = comment_thread_parms
    updated_parms[:bumped_at] = DateTime.now
    @comment_thread = CommentThread.new(updated_parms)
    if @comment_thread.save
      redirect_to @comment_thread
    else
      render 'new'
    end
  end

  def destroy
    @comment_thread = CommentThread.find(params[:id])
    @comment_thread.destroy

    redirect_to comment_thread_path
  end

  private

  def comment_thread_parms
    params.require(:comment_thread).permit(:title, :content, :user_id)
  end

end
