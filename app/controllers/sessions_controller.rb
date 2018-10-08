class SessionsController < ApplicationController
  
  def new
  end

  def create
    
    user = User.find_by(email: params[:session][:email].downcase)
   
    # If we found the user, and the password is correct... 
    if user && user.authenticate(params[:session][:password])
      log_in user 
      redirect_to user 
    else 
      # ...otherwise, render the page again with error messages displayed 
      flash.now[:danger] = "Invalid email address or password." 
      render 'new'
    end
    
  end

  def destroy
  
    if logged_in?
      log_out
      redirect_to root_url
    end

  end

end
