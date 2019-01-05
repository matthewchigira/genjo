require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:bob)
    login(@user) 
  end

  test "should get new" do
    get new_user_path
    assert_response :success
  end

  test "should create user (send email)" do
    post users_path, params: { user: { name: "John Smith",
                                       email: "john.smith@gmail.com",
                                       password: "password",
                                       password_confirmation: "password" } }
    assert_equal "To use Genjo! you must confirm your email address. " \
                 "Please check your email inbox for your confirmation " \
                 "email.", flash[:success]
    assert_redirected_to root_url 
  end

  test "should update user" do
    patch user_url(@user), params: { user: { name: "Bobby" } }
    assert_equal "User profile updated", flash[:success]
    assert_redirected_to user_url(@user.id)
  end

  test "should destroy user (send email)" do
    delete user_path(@user)
    assert_equal "Account deletion email has been sent, please check "\
                 "your inbox", flash[:info]
    assert_redirected_to root_url
  end

end
