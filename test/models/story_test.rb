require "test_helper"

class StoryTest < ActiveSupport::TestCase
  test "should be valid with valid attributes" do
    story = Story.new(title: "Test Story", url: "https://example.com", user: users(:one))
    assert story.valid?
  end

  test "should not be valid without a title" do
    story = Story.new(url: "https://example.com", user: users(:one))
    assert_not story.valid?
    assert_includes story.errors[:title], "can't be blank"
  end

  test "should not be valid without a url" do
    story = Story.new(title: "Test Story", user: users(:one))
    assert_not story.valid?
    assert_includes story.errors[:url], "can't be blank"
  end

  test "should not be valid without a user" do
    story = Story.new(title: "Test Story", url: "https://example.com")
    assert_not story.valid?
    assert_includes story.errors[:user], "must exist"
  end

  test "url should be a valid URL" do
    story = Story.new(title: "Test Story", url: "not_a_url", user: users(:one))
    assert_not story.valid?
    assert_includes story.errors[:url], "is invalid"
  end

  test "should have zero votes when created" do
    story = Story.create(title: "Test Story", url: "https://example.com", user: users(:one))
    assert_equal 0, story.votes.count
  end
end
