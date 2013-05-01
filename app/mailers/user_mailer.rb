class UserMailer < ActionMailer::Base
  default from: "crowdfunder@example.com"

  def new_pledge(pledge)
    @pledge = pledge
    @project = @pledge.project
    @user = @project.user
    @backer = @pledge.user

    subject = "Someone has backed your project!"
    mail to: @user.email, subject: subject
  end
end
