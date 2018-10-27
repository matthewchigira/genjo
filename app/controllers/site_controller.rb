class SiteController < ApplicationController
  
  def home
    if logged_in? 
      @user = User.find(current_user.id)

      # Show the top 3 targets 
      @targets = @user.targets[0..2]

      # Show the top 10 diary entries
      @diaries = @user.diaries[0..9]

      # Show the top 5 tasks
      @tasks = @user.tasks[0..4]
    end 
  end

  def about
  end

  def contact
  end

  def help
  end
end
