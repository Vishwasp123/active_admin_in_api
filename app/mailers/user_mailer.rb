class UserMailer < ApplicationMailer
  def approve_email(user)
    @user = user
    mail(to: @user.email, subject: "Approve")
  end
end
