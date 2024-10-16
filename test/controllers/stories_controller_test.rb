require "test_helper"

class StoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @story = stories(:one)
  end

  test "should get index" do
    get stories_path
    assert_response :success
  end

  test "should get new" do
    get new_story_url
    assert_response :redirect
  end

  test "should create story" do
    sign_in_as users(:one), "password"
    assert_difference("Story.count") do
      post stories_path, params: { story: { description: @story.description, title: @story.title,url: @story.url, user_id: @story.user_id } }
    end

    assert_redirected_to story_url(Story.last)
  end

  test "should show story" do
    get story_url(@story)
    assert_response :success
  end

  test "should get edit" do
    get edit_story_url(@story)
    assert_response :redirect
  end

  test "should update story" do
    patch story_url(@story), params: { story: { description: @story.description, title: @story.title, user_id: @story.user_id } }
    assert_redirected_to new_session_path
  end

  test "should destroy story" do
    sign_in_as users(:one), "password"
    assert_difference("Story.count", -1) do
      delete story_url(@story)
    end

    assert_redirected_to stories_url
  end
end
