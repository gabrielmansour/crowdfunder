class SessionsController < ApplicationController
  def new
  end

  def create
    user = login params[:email], params[:password]
    if user
      redirect_back_or_to root_path, notice: "Welcome back."
    else
      flash.now[:alert] = "Invalid email or password."
      render :new
    end
  end

  def destroy
    logout
    redirect_back_or_to root_path, alert: "You have been logged out."
  end
end
