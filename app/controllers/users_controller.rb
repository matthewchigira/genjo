class UsersController < ApplicationController

  def index

  end

  def create
    
    # Create a new User with the values from the page's input form 
    @user = User.new(user_params) 
    
    # Try to save the record to the database... 
    if @user.save 
      # ...save must have worked: send confirmation email and flash message 
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

  end

  def show

  end

  def update

  end

  def destroy

  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

end
