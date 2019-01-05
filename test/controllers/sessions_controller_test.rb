require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
 
  def setup
    @user = users(:bob)
  end
  
  test "should get login" do
    get login_path
    assert_response :success
  end

  test "should create session (login)" do
    post login_path, params: { session: { email: @user.email,
                                          password: "password" } }
    assert is_logged_in?
    assert_redirected_to user_path(@user.id)
  end

  test "should destroy session (logout)" do
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url  
  end

end
