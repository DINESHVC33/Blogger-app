# Preview all emails at http://localhost:3000/rails/mailers/user
class UserPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user/welcome_mail
  def welcome_mail
    UserMailer.welcome_mail
  end

end
