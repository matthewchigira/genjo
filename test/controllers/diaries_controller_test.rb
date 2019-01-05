require 'test_helper'

class DiariesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:bob)
    @diary = diaries(:one) 
    login(@user)
  end

  teardown do
    Rails.cache.clear
  end

  test "should get index" do 
    get diaries_url
    assert_response :success
  end
  
  test "should show diary" do
    get diary_url(@diary)
    assert_response :success 
  end

  test "should create diary" do
    assert_difference('Diary.count') do
      post diaries_url, params: { diary: { user_id: @user.id,
                                           title: "New Diary",
                                           entry: "Diary entry",
                                           date: DateTime.now } } 
    end
    assert_redirected_to diaries_path
    assert_equal "New diary entry created", flash[:success]
  end

  test "should update diary" do
    patch diary_url(@diary), params: { diary: { entry: "Different value" } }
    assert_redirected_to diaries_path
    assert_equal "Diary updated", flash[:success]
  end

  test "should destroy diary" do
    assert_difference('Diary.count', -1) do
      delete diary_url(@diary)
    end
    assert_equal "Diary entry deleted", flash[:success]
  end

end
