class InviteMailer < ActionMailer::Base
  default from: 'no-reply@mmmine.com'
 
  def send_invitation(email_to, from_user)
    mail(to: email_to, subject: "Your friend, #{from_user.name}, thinks you'll love mmmine.com")
  end

end