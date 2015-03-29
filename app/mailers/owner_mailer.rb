class OwnerMailer < ActionMailer::Base
default from: "info@wheremydogsat.com"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.owner_mailer.welcome.subject
  #
  def welcome(owner)
    @greeting = "Hi"
    @first_name = owner[:first_name]
    email=owner[:email]
    # mail to: email, subject: 'Welcome to Where My Dogs At?'
    mail to: email
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.owner_mailer.invite_friends.subject
  #
  def invite_friends (owner_name, friend_name, friend_email)
    @greeting = "Hi"
    @owner_name=owner_name
    @friend_name=friend_name
    mail to: friend_email
  end
  def forgot_password(owner)
    @owner = owner
    @greeting = "Hi"

    mail to: @owner.email, :subject => 'Reset password instructions'
  end
end
