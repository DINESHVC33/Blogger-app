class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome_mail.subject
  #
  def welcome_mail
    @user=params[:user]
    @greeting = "Hi"

    mail(from:"BloggerApp@gmail.com",
         to:@user.email,
         subject: "Sign_up welcome mail"
    )
  end
end
