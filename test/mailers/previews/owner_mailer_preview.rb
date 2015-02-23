# Preview all emails at http://localhost:3000/rails/mailers/owner_mailer
class OwnerMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/owner_mailer/welcome
  def welcome
    OwnerMailer.welcome
  end

  # Preview this email at http://localhost:3000/rails/mailers/owner_mailer/invite_friends
  def invite_friends
    OwnerMailer.invite_friends
  end

end
