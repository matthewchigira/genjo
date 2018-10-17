class AccountActivationsController < ApplicationController

  def edit
    # The account activation email will provide us with an email address 
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.token_authenticated?(params[:id], :activation)
      user.activate 
      log_in user
      flash[:success] = "Account activated!"
      redirect_to user
    else
      flash[:danger] = "Activation link was invalid"
      redirect_to root_url
    end
  end

end
