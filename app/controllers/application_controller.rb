class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def not_authenticated
    redirect_to login_path, alert: "Please log in first."
  end
end
