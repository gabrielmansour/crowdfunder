class ProjectsController < ApplicationController
  def index
    @projects = Project.order(:created_at).reverse_order.page(params[:page])
  end

  def show
    @project = Project.find(params[:id])
  end
end
