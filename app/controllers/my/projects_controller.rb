class My::ProjectsController < ApplicationController
  before_filter :require_login

  def index
    @projects = current_user.projects
  end

  def new
    @project = current_user.projects.new
  end

  def create
    @project = current_user.projects.new(params[:project])
    if @project.save
      redirect_to @project, notice: "Your project was created!"
    else
      render :new
    end
  end

  def edit
    @project = current_user.projects.find(params[:id])
  end

  def update
    @project = current_user.projects.find(params[:id])
    if @project.update_attributes(params[:project])
      redirect_to my_projects_path, notice: "Project updated."
    else
      render :edit
    end
  end
end
