class ProjectsController < ApplicationController

  def show
    @project = Project.find(params[:id])
  end

  def new
  end

  def create
    @project = Project.new(params.require(:project).permit(:title, :text, :date, :imagelink))

    @project.save
    redirect_to @project
  end

end
