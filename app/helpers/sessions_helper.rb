module SessionsHelper

  # Log the given user in 
  def log_in(user)
    # Store an encrypted version of the given user's ID in a temporary session
    # cookie. This cookie will expire when the broswer is closed.
    session[:user_id] = user.id
  end

  # Log the current user out
  def log_out
    # If persistant session is being used, forget it  
    forget(current_user) 
    # Then delete the temporary :user_id cookie and blank out @current_user 
    session.delete(:user_id)
    @current_user = nil
  end

  # Is there a user currently logged in?
  def logged_in?
    !current_user.nil? 
  end

  # Return the currently logged in user
  def current_user
    # First, look for user in temporary session cookies 
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    # Next, look in persistantly stored cookies 
    elsif (user_id = cookies.signed[:user_id])
      user ||= User.find_by(id: user_id)
      if user && user.token_authenticated?(cookies[:remember_token])
        # Once we have the user, use temporary sessions cookies 
        log_in user
        @current_user = user
      end
    end
  end

  # Is this user the current user?
  def current_user?(user)
    user == @current_user
  end

  # Remember the given user, for persistent sessions
  def remember(user)
    # Generate a token, and save a hash of this in the db
    user.remember_user
    # signed encrypts these values... 
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Delete all trace of a user's persistant session from the browser and db 
  def forget(user)
    # Delete digest from the db
    user.forget_user
    # Delete the cookies from the browser
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end 

end
