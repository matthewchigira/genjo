class TasksController < ApplicationController
  before_action :user_logged_in
  before_action :task_exists, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
 
  def index
    @tasks = current_user.tasks.paginate(page: params[:page])
    @user = current_user 
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = current_user.tasks.build
  end

  def edit
    @task = Task.find(params[:id])
  end

  def create
    # The Task model is child data to the User model 
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = "New task created"
      redirect_to tasks_path
    else
      # Redisplay the new screen, with error messages
      render 'new'
    end
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(task_params)
      flash[:success] = "Task updated"
      redirect_to tasks_path 
    else
      # Redisplay the edit screen, with error messages
      render 'edit'
    end
  end

  def destroy
    Task.find(params[:id]).destroy
    flash[:success] = "Task deleted"
    redirect_back fallback_location: tasks_path
  end
  
  private

    # Define which parameters are allowed to passed around, for secutiry.
    def task_params
      params.require(:task).permit(:name, :description, :due_date,
                                   :is_high_priority, :is_complete)
    end
    
    # Before filters

    def user_logged_in
      unless logged_in?
        flash[:danger] = "Please log in to access this page."
        redirect_to login_url
      end
    end

    def task_exists
      redirect_to root_url unless Task.exists?(params[:id]) 
    end 

    def correct_user
      @task = Task.find(params[:id])
      redirect_to root_url unless current_user.id == @task.user_id
    end

end
