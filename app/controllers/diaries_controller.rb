class DiariesController < ApplicationController
  before_action :user_logged_in
  before_action :diary_exits, only: [:show, :edit]
  
  def index
    @diaries = current_user.diaries.paginate(page: params[:page]) 
  end

  def show
    @diary = Diary.find(params[:id])
  end

  def new
    @diary = current_user.diaries.build
  end

  def edit

  end

  def create
   
    @diary = current_user.diaries.build(diary_params)

    if @diary.save
      flash[:success] = "New diary entry created"
      redirect_to diaries_path
    else
      render 'new'
    end
   
  end

  def update

  end

  def destroy

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
end
