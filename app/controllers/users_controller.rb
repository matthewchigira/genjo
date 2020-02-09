class UsersController < ApplicationController
  before_action :user_logged_in, only: [:show, :edit, :update, :destroy] 
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  before_action :admin_user, only: [:index]

  def index
    # User admin page
    @users = User.all.paginate(page: params[:page])
    render 'index'
  end

  def create
    
    # Create a new User with the values from the page's input form 
    @user = User.new(user_params) 
    
    # Try to save the record to the database... 
    if @user.save 
      # ...save must have worked: send confirmation email and flash message 
      @user.send_activation_email 
      flash[:success] = "To use Genjo! you must confirm your email address. " \
                        "Please check your email inbox for your confirmation " \
                        "email." 
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
    @diaries = @user.diaries.paginate(page: params[:page])
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
    @user = User.find(params[:id])

    # Admin users can directly delete a user
    if current_user.admin
      @user.destroy
      flash[:success] = "User deleted"
      redirect_to users_path

    # Normal users can request to delete themselves
    else
      if @user
        @user.create_account_deletion_digest
        @user.send_account_deletion_email
        flash[:info] = "Account deletion email has been sent, please check "\
          "your inbox"
        redirect_to root_url
      end
    end
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
    rescue ActiveRecord::RecordNotFound => e
      logger.error "Error: #{e}"
    ensure
      redirect_to root_url unless current_user?(@user) or current_user.admin
    end

    def admin_user
      unless logged_in? and current_user.admin == true
        redirect_to root_path
      end
    end
end
