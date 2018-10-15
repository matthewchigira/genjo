require 'test_helper'

class TaskTest < ActiveSupport::TestCase

  def setup
    @user = users(:bob)
    @task = tasks(:one)
  end
  
  test "should be valid" do
    assert @task.valid?
  end

  test "user id should be present" do
    @task.user_id = nil
    assert_not @task.valid?
  end

  test "name should be present" do
    @task.name = " "
    assert_not @task.valid?
  end

  test "name should be no more than 30 characters" do
    @task.name = "a" * 31
    assert_not @task.valid?
  end

  test "description should be present" do
    @task.description = " "
    assert_not @task.valid?
  end

end
