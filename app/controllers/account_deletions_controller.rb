class AccountDeletionsController < ApplicationController

  def show 
  end

  def edit
    # The account deletion email will provide us with an email address 
    user = User.find_by(email: params[:email])
    if user && user.token_authenticated?(params[:id], :deletion)
      user.destroy 
      redirect_to accountdeleted_url 
    else
      flash[:danger] = "Deletion link was invalid"
      redirect_to root_url
    end
  end

end
