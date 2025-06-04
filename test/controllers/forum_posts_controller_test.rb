require "test_helper"

class ForumPostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @forum_post = forum_posts(:one)
  end

  test "should get index" do
    get forum_posts_url
    assert_response :success
  end

  test "should get show" do
    get forum_post_url(@forum_post)
    assert_response :success
  end

  test "should get new" do
    get new_forum_post_url
    assert_response :success
  end

  test "should create forum post" do
    assert_difference("ForumPost.count") do
      post forum_posts_url, params: {
        forum_post: {
          title: "Test Post",
          content: "This is a test forum post.",
          user_id: @user.id
        }
      }
    end
    assert_redirected_to forum_post_url(ForumPost.last)
  end

  test "should get edit" do
    get edit_forum_post_url(@forum_post)
    assert_response :success
  end

  test "should update forum post" do
    patch forum_post_url(@forum_post), params: {
      forum_post: {
        title: "Updated Title"
      }
    }
    assert_redirected_to forum_post_url(@forum_post)
  end

  test "should destroy forum post" do
    assert_difference("ForumPost.count", -1) do
      delete forum_post_url(@forum_post)
    end
    assert_redirected_to forum_posts_url
  end
end
