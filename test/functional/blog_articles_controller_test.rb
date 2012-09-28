require 'test_helper'

class BlogArticlesControllerTest < ActionController::TestCase
  setup do
    @blog_article = blog_articles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:blog_articles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create blog_article" do
    assert_difference('BlogArticle.count') do
      post :create, blog_article: { author_id: @blog_article.author_id, content: @blog_article.content, online: @blog_article.online, title: @blog_article.title }
    end

    assert_redirected_to blog_article_path(assigns(:blog_article))
  end

  test "should show blog_article" do
    get :show, id: @blog_article
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @blog_article
    assert_response :success
  end

  test "should update blog_article" do
    put :update, id: @blog_article, blog_article: { author_id: @blog_article.author_id, content: @blog_article.content, online: @blog_article.online, title: @blog_article.title }
    assert_redirected_to blog_article_path(assigns(:blog_article))
  end

  test "should destroy blog_article" do
    assert_difference('BlogArticle.count', -1) do
      delete :destroy, id: @blog_article
    end

    assert_redirected_to blog_articles_path
  end
end
