class SiteController < ApplicationController
  
  def home
    if logged_in? 
      @user = User.find(current_user.id)
      @targets = @user.targets.paginate(page: params[:page])
      @diaries = @user.diaries.paginate(page: params[:page])
      @tasks = @user.tasks.paginate(page: params[:page])
    end 
  end

  def about
  end

  def contact
  end

  def help
  end
end
