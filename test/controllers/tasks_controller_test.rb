require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
 
  def setup
    @user = users(:bob)
    @task = tasks(:one) 
    login(@user)
  end

  teardown do
    Rails.cache.clear
  end

  test "should get index" do 
    get tasks_url
    assert_response :success
  end
  
  test "should show task" do
    get task_url(@task)
    assert_response :success 
  end

  test "should create task" do
    assert_difference('Task.count') do
      post tasks_url, params: { task: { name: "New Task",
                                        description: "Task Description" } } 
    end
    assert_redirected_to tasks_path
    assert_equal "New task created", flash[:success]
  end

  test "should update task" do
    patch task_url(@task), params: { task: { description: "Different value" } }
    assert_redirected_to tasks_path
    assert_equal "Task updated", flash[:success]
  end

  test "should destroy task" do
    assert_difference('Task.count', -1) do
      delete task_url(@task)
    end
    assert_equal "Task deleted", flash[:success]
  end

end
