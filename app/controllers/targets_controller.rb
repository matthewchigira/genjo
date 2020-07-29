class TargetsController < ApplicationController
  before_action :user_logged_in
  before_action :target_exits, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
 
  def index
    @targets = current_user.targets.paginate(page: params[:page])
    @user = current_user 
  end

  def show
    @target = Target.find(params[:id])
  end

  def new
    @target = current_user.targets.build
  end

  def edit
    @target = Target.find(params[:id])
  end

  def create
    # The Target model is child data to the User model 
    @target = current_user.targets.build(target_params)
    if @target.save
      flash[:success] = "New target created"
      redirect_to targets_path
    else
      # Redisplay the new screen, with error messages
      render 'new'
    end
  end

  def update
    @target = Target.find(params[:id])
    if @target.update_attributes(target_params)
      flash[:success] = "Target updated"
      redirect_to targets_path 
    else
      # Redisplay the edit screen, with error messages
      render 'edit'
    end
  end

  def destroy
    Target.find(params[:id]).destroy
    flash[:success] = "Target deleted"
    redirect_back fallback_location: targets_path
  end
  
  private

    # Define which parameters are allowed to passed around, for secutiry.
    def target_params
      params.require(:target).permit(:name, :description, :target_steps,
                                     :completed_steps, :step_name, :sort_order)
    end
    
    # Before filters

    def user_logged_in
      unless logged_in?
        flash[:danger] = "Please log in to access this page."
        redirect_to login_url
      end
    end

    def target_exits
      redirect_to root_url unless Target.exists?(params[:id]) 
    end 

    def correct_user
      @target = Target.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      logger.error "Error: #{e}"
    ensure
      redirect_to root_url unless current_user.id == @target.user_id
    end

end
