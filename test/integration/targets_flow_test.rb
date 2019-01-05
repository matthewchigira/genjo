require 'test_helper'

class TargetsFlowTest < ActionDispatch::IntegrationTest
 
  def setup
    @user = users(:bob)
    @target = targets(:one)
    login(@user)
  end
  
  test "can create a target" do
    get new_target_path
    assert_response :success
    post targets_path, params: { target: { user: @user.id,
                                           name: "Target name",
                                           description: "Target description",
                                           target_steps: 10,
                                           step_name: "Chapters" } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end
  
  test "can edit a target" do
    get edit_target_path(@target)
    assert_response :success
    patch target_path(@target), params: { target: { name: "New name",
                                                    description: "New desc.",
                                                    target_steps: 12,
                                                    completed_steps: 6,
                                                    step_name: "Lessons" } } 
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

  test "can delete a target" do
    assert_difference 'Target.count', -1 do 
      delete target_path(@target)
    end
    assert_response :redirect
    follow_redirect!
  end

end
