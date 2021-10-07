class UserMailer < ApplicationMailer

  def account_confirmation(user, activation_token)
    @user = user
    @activation_token = activation_token
    @url = edit_account_activation_url(@activation_token, email: @user.email)
    mail(
      to: @user.email, 
      subject: "Account activation - tiendacodigo"
    )
  end
end
