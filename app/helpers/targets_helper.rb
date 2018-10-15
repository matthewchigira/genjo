module TargetsHelper

  def calculate_percentage(id = 0)
    
    if id == 0 then
      target = Target.find(params[:id])
    else
      target = Target.find(id)
    end 
    
    ((target.completed_steps.to_f / target.target_steps.to_f) * 100).to_s

  end

  def generate_message(id = 0)
    
    if id == 0 
      target = Target.find(params[:id])
    else
      target = Target.find(id)
    end
    
    target.completed_steps.to_s + " out of " + target.target_steps.to_s \
      + " " + target.step_name + " complete"
  
  end

end
