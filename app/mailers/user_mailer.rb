class UserMailer < ApplicationMailer
  default from: 'viewingparty714@gmail.com'

  def party_invitation
    friends_emails = params[:invitee_emails]
    inviter_email = params[:inviter_email]
    mail(to: friends_emails, from: inviter_email, subject: 'Movie Party Invitation')
  end
end