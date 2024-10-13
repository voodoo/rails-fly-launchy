require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task = tasks(:one)
  end

  test "should get index" do
    get tasks_path
    assert_response :success
  end  
  
  test "should get index and show pending tasks" do
    get tasks_path
    assert_response :success
    assert_select "span", "Pending"
    #assert_select ".task", minimum: 1
  end
  
  test "should not get new" do
    get new_task_path
    assert_response :redirect
  end

  test "should get new" do
    sign_in_as users(:one), "password"
    get new_task_path
    assert_response :success
  end

  test "should create task" do
    sign_in_as users(:one), "password"
    assert_difference("Task.count") do
      post tasks_path, params: { task: { title: "New Task", description: "Task description", due_date: Date.tomorrow, user_id: 1 } }
    end

    assert_redirected_to tasks_path
  end

  test "should show task when not signed in" do
    get task_path(@task)
    assert_redirected_to new_session_path
  end
  test "should show task when signed in" do
    sign_in_as users(:one), "password"
    get task_path(@task)
    assert_response :success
  end

  # test "should get edit" do
  #   get edit_task_path(@task)
  #   assert_response :success
  # end

  # test "should update task" do
  #   patch task_path(@task), params: { task: { title: "Updated Task", description: "Updated description" } }
  #   assert_redirected_to task_path(@task)
  #   @task.reload
  #   assert_equal "Updated Task", @task.title
  #   assert_equal "Updated description", @task.description
  # end

  # test "should destroy task" do
  #   assert_difference("Task.count", -1) do
  #     delete task_path(@task)
  #   end

  #   assert_redirected_to tasks_path
  # end

  # test "should not access tasks of other users" do
  #   other_user = users(:two)
  #   other_task = tasks(:two)

  #   get task_path(other_task)
  #   assert_response :redirect
  #   assert_redirected_to root_path
  #   assert_equal "You are not authorized to access this task.", flash[:alert]
  # end
end
