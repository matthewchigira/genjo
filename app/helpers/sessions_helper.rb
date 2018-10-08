module SessionsHelper

  # Log the given user in 
  def log_in(user)
    # Store an encrypted version of the given user's ID in a temporary session
    # cookie. This cookie will expire when the broswer is closed.
    session[:user_id] = user.id
  end

  # Log the current user out
  def log_out
    # Delete the :user_id cookie and blank out @current_user 
    session.delete(:user_id)
    @current_user = nil
  end

  # Is there a user currently logged in?
  def logged_in?
    !current_user.nil? 
  end

  # Return the currently logged in user
  def current_user
    if session[:user_id]
      # Return logged in user, or, if null, find it
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  # Is this user the current user?
  def current_user?(user)
    user.equals?(@current_user)
  end

end
