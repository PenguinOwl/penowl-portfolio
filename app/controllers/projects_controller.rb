require "markdown"

class ProjectsController < ApplicationController

  before_action except: [:index, :show] do
    authenticate_user!
    user_flag "admin"
  end

  def index
    @projects = Project.all.sort_by {|project| project.catagory}
  end

  def show
    @project = Project.find(params[:id])
    @renderer = Redcarpet::Markdown.new(MarkdownRenderer, no_intra_emphasis: true, autolink: true, fenced_code_blocks: true, disable_indented_code_blocks: true)
  end

  def new
    @project = Project.new
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])

    if @project.update(project_params)
      redirect_to @project
    else
      render 'edit'
    end
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to @project
    else
      render 'new'
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:title, :text, :date, :imagelink)
  end

end
