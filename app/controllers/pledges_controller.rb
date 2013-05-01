class PledgesController < ApplicationController
  before_filter :require_login
  before_filter :load_project

  def new
    @pledge = @project.pledges.new
  end
  
  def create
    @pledge = @project.pledges.new(params[:pledge])
    @pledge.user = current_user
    if @pledge.save
      UserMailer.new_pledge(@pledge).deliver
      redirect_to @project, notice: "Hooray! You pledged $#{@pledge.amount}!"
    else
      render :new
    end
  end

  private

  def load_project
    @project = Project.find(params[:project_id])
  end
end
