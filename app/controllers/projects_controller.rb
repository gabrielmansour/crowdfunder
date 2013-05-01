class ProjectsController < ApplicationController
  def index
    @projects = Project.order(:created_at).reverse_order.page(params[:page])
    @projects = @projects.where(["title ILIKE ?", "%#{params[:q]}%"]) if params[:q].present?
  end

  def show
    @project = Project.find(params[:id])
  end
end
