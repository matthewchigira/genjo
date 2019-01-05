require 'test_helper'

class PasswordResetsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:bob)  
  end

  test "should create password reset request" do
    post password_resets_url, params: { password_reset: { email: @user.email } }
    @user.reload
    assert_not_nil @user.reset_digest
    assert_equal "Email has been sent with password reset instructions", flash[:info]
    assert_redirected_to root_url
  end

  test "should reset password" do
    @user.create_password_reset_digest
    patch password_reset_url(@user.reset_token), 
      params: { email: @user.email,  
                user: { password: "newpassword", 
                        password_confirmation: "newpassword" } }
    assert_equal "Password successfully reset.", flash[:success]
    assert_redirected_to user_url(@user) 
  end

end
