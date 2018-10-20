class PasswordResetsController < ApplicationController
  before_action :get_user,         only: [:edit, :update]
  before_action :valid_user,       only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]
  
  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_password_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Email has been sent with password reset instructions"
      redirect_to root_url
    else
      flash[:danger] = "Email address was not found"
      render 'new'
    end
  end

  def edit
  end

  def update
    if params[:user][:password].empty? 
      # Because password field validation is set to allow_nil,
      # this extra code is needed to prevent null values being entered  
      @user.errors.add(:password, "can't be empty")
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @user
      flash[:success] = "Password succesfully reset."
      redirect_to @user
    else
      render 'edit'
    end
  end 
  
  private
   
    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def get_user
      @user = User.find_by(email: params[:email])
    end

    def valid_user
      if !@user || !@user.activated? || 
         !@user.token_authenticated?(params[:id], :reset)
        redirect_to root_url
      end
    end
    
    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "This password reset email has expired"
        redirect_to new_password_reset_url
      end 
    end 

end
