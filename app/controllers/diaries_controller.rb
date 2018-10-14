class DiariesController < ApplicationController
  before_action :user_logged_in
  before_action :diary_exits, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  
  def index
    @diaries = current_user.diaries.paginate(page: params[:page])
    @user = current_user 
  end

  def show
    @diary = Diary.find(params[:id])
  end

  def new
    @diary = current_user.diaries.build
  end

  def edit
    @diary = Diary.find(params[:id]) 
  end

  def create
    # The Diary model is child data to the User model 
    @diary = current_user.diaries.build(diary_params)
    if @diary.save
      flash[:success] = "New diary entry created"
      redirect_to diaries_path
    else
      # Redisplay the new screen, with error messages
      render 'new'
    end
  end

  def update
    @diary = Diary.find(params[:id])
    if @diary.update_attributes(diary_params)
      flash[:success] = "Diary updated"
      redirect_to diaries_path
    else
      # Redisplay the edit screen, with error messages
      render 'edit'
    end
  end

  def destroy
    Diary.find(params[:id]).destroy
    flash[:success] = "Diary entry deleted"
    redirect_to diaries_path
  end

  private

    # Define which parameters are allowed to passed around, for secutiry.
    def diary_params
      params.require(:diary).permit(:date, :title, :entry)
    end
    
    # Before filters

    def user_logged_in
      unless logged_in?
        flash[:danger] = "Please log in to access this page."
        redirect_to login_url
      end
    end

    def diary_exits
      redirect_to root_url unless Diary.exists?(params[:id]) 
    end 

    def correct_user
      @diary = Diary.find(params[:id])
      redirect_to root_url unless current_user.id == @diary.user_id
    end
end
