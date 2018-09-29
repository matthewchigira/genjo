module ApplicationHelper
  def generate_page_title(title ='')
    
    base_title = "Genjo!" 
    
    # If the view did not provide a page title... 
    if title.empty?
      # ...use the default title
      base_title 
    else
      # ...otherwise append the app name to the given string
      title = title.to_s + " | " + base_title 
    end
  end
end
