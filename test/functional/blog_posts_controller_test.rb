require 'test_helper'

class BlogPostsControllerTest < ActionController::TestCase
  setup do
    @blogpost = blogs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:blog_posts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create blogpost" do
    assert_difference('BlogPost.count') do
      post :create, blogpost: { author_id: @blogpost.author_id, content: @blogpost.content, permalink: @blogpost.permalink, published_at: @blogpost.published_at, title: @blogpost.title }
    end

    assert_redirected_to blog_path(assigns(:blogpost))
  end

  test "should show blogpost" do
    get :show, id: @blogpost
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @blogpost
    assert_response :success
  end

  test "should update blogpost" do
    put :update, id: @blogpost, blogpost: { author_id: @blogpost.author_id, content: @blogpost.content, permalink: @blogpost.permalink, published_at: @blogpost.published_at, title: @blogpost.title }
    assert_redirected_to blog_path(assigns(:blogpost))
  end

  test "should destroy blogpost" do
    assert_difference('BlogPost.count', -1) do
      delete :destroy, id: @blogpost
    end

    assert_redirected_to blogs_path
  end
end
