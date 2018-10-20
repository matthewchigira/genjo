class UsersController < ApplicationController
  before_action :user_logged_in, only: [:show, :edit, :update] 
  before_action :correct_user, only: [:show, :edit, :update]
  
  def index

  end

  def create
    
    # Create a new User with the values from the page's input form 
    @user = User.new(user_params) 
    
    # Try to save the record to the database... 
    if @user.save 
      # ...save must have worked: send confirmation email and flash message 
      @user.send_activation_email 
      flash[:success] = "To use Genjo! you must confirm your email address.
                         Please check your email inbox for your confirmation 
                         email." 
      redirect_to root_url
    else
      # ...save must have failed: re-render the 'new' view, showing the errors 
      render 'new'
    end

  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "User profile updated"
      redirect_to @user 
    else
      # Redisplay the edit screen with errors highlighted
      render 'edit'
    end 
  end

  def destroy

  end
  
  private
    
    # For security reasons, only allow these page parameters
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def user_logged_in
      unless logged_in?
        flash[:danger] = "Please log in to access this page."
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_url unless current_user?(@user)
    end
    
end
