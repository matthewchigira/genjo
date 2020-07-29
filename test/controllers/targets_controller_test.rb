require 'test_helper'

class TargetsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:bob)
    @target = targets(:kanji)
    login(@user)
  end

  teardown do
    Rails.cache.clear
  end

  test "should get index" do 
    get targets_url
    assert_response :success
  end
  
  test "should show targets" do
    get target_url(@target)
    assert_response :success 
  end

  test "should create target" do
    assert_difference('Target.count') do
      post targets_url, params: { target: { name: "New Target",
                                            description: "Finish Book",
                                            target_steps: 12,
                                            completed_steps: 5,
                                            step_name: "Chapters" } } 
    end
    assert_redirected_to targets_path
    assert_equal "New target created", flash[:success]
  end

  test "should update target" do
    patch target_url(@target), params: { target: { name: "Different value",
                                                   description: "Different value",
                                                   target_steps: 14,
                                                   completed_steps: 6,
                                                   step_name: "Different value",
                                                   sort_order: 1 } }
    assert_redirected_to targets_path
    assert_equal "Target updated", flash[:success]
  end

  test "should destroy target" do
    assert_difference('Target.count', -1) do
      delete target_url(@target)
    end
    assert_equal "Target deleted", flash[:success]
  end

end
