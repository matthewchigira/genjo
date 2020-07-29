require 'test_helper'

class TargetTest < ActiveSupport::TestCase

  def setup
    @user = users(:bob)
    @target = targets(:kanji)
  end

  test "should be valid" do
    assert @target.valid?
  end

  test "user id should be present" do
    @target.user_id = nil 
    assert_not @target.valid?
  end

  test "name should be present" do
    @target.name = " "
    assert_not @target.valid?
  end

  test "name should not be longer than 30 characters" do
    @target.name = "a" * 31
    assert_not @target.valid?
  end

  test "description should be present" do
    @target.description = " " 
    assert_not @target.valid?
  end

  test "target steps must be greater than 0" do
    @target.target_steps = -1
    assert_not @target.valid?
    @target.target_steps = 0
    assert_not @target.valid?
  end  

  test "target steps must be less than 100,000" do
    @target.target_steps = 100001
    assert_not @target.valid?
  end

  test "completed steps must be non negative" do  
    @target.completed_steps = -1
    assert_not @target.valid? 
  end

  test "completed steps cannot exceed target steps" do
    @target.target_steps = 10 
    @target.completed_steps = 11 
    assert_not @target.valid? 
  end

  test "step name should be present" do
    @target.step_name = " "
    assert_not @target.valid?
  end

  test "step name should be no longer than 30 characters" do
    @target.step_name = "a" * 31
    assert_not @target.valid?
  end

  test "sort order must be above 0" do
    @target.sort_order = -1
    assert_not @target.valid?
  end

  test "sort order must not be larger than count of rows" do
    @target.sort_order = Target.where(user_id: @target.user_id).count + 1
    assert_not @target.valid?
  end
end
