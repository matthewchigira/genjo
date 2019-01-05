require 'test_helper'

class TasksFlowTest < ActionDispatch::IntegrationTest
   
  def setup
    @user = users(:bob)
    @task = tasks(:one)
    login(@user)
  end
  
  test "can create a task" do
    get new_task_path
    assert_response :success
    post tasks_path, params: { task: { user: @user.id,
                                        name: "Task name",
                                        description: "Task description",
                                        due_date: (Time.zone.now + 1.week),
                                        is_high_priority: true,
                                        is_complete: false } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end
  
  test "can edit a task" do
    get edit_task_path(@task)
    assert_response :success
    patch task_path(@task), params: { task: { name: "New name",
                                              description: "New desc.",
                                              due_date: (Time.zone.now + 1.day),
                                              is_high_priority: false,
                                              is_complete: true } } 
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

  test "can delete a task" do
    assert_difference 'Task.count', -1 do 
      delete task_path(@task)
    end
    assert_response :redirect
    follow_redirect!
  end

end
