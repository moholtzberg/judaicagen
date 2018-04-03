class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'
 
  def sold_email(item)
    @user = item.owner
    @url  = ''
    mail(to: @user.email, subject: 'Judaicagen - Your ' << item.title)
  end

  def bought_email(user)
    @user = user
    @url  = ''
    mail(to: @user.email, subject: 'Judaicagen - Your purchase')
  end
end
