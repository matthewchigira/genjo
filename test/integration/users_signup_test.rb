require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information provided" do
    
    # Browse to the signup page 
    get signup_path

    # Fill in form with invalid information 
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { name: "",
                                         email: "user@example",
                                         password: "short",
                                         password_confirmation: "short" } }
    end

    # Ensure that the 'new' page was reloaded because the save failed
    assert_template 'users/new'

  end

  test "valid signup information provided" do
    
    # Browse to the signup page
    get signup_path

    # Fill in form with valid information
    assert_difference 'User.count' do
      post signup_path, params: { user: { name: "Example User",
                                          email: "user@example.com",
                                          password: "password",
                                          password_confirmation: "password" } }
    end

    # Ensure that the home page was loaded, which means it worked
    follow_redirect!
    assert_template 'site/home' 
                                          
  end

end
