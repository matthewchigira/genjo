class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Genjo! Account activation" 
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Genjo! Password reset" 
  end

  def account_deletion(user)
    @user = user
    mail to: user.email, subject: "Genjo! Account deletion" 
  end

end
