require 'test_helper'

class AccountActivationsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.new(name: "John Smith", 
                     email: "john.smith@gmail.com", 
                     password: "password", 
                     password_confirmation: "password")
    @user.save 
  end

  test "should activate account" do
    get edit_account_activation_url(@user.activation_token), 
                                    params: { email: @user.email }
    @user.reload 
    assert_equal true, @user.activated 
    assert_equal "Account activated!", flash[:success]
    assert_redirected_to user_url(@user)  
  end

end
