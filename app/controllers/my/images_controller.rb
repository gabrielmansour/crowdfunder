class My::ImagesController < ApplicationController
  before_filter :require_login
  before_filter :load_project

  def index
    @images = @project.images
  end

  def create
    @image = @project.images.build(params[:image])
    if @image.save
      redirect_to my_project_images_path(@project)
    else
      @images = @project.images.reload
      flash.now[:alert] = "Image upload failed."
      render :index
    end
  end

  private

  def load_project
    @project = current_user.projects.find(params[:project_id])
  end
end
