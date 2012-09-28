class BlogArticlesController < ApplicationController
  before_filter :authenticate_user!

  # GET /blog_articles
  # GET /blog_articles.json
  def index
    @blog_articles = BlogArticle.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @blog_articles }
    end
  end

  # GET /blog_articles/1
  # GET /blog_articles/1.json
  def show
    @blog_article = BlogArticle.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @blog_article }
    end
  end

  # GET /blog_articles/new
  # GET /blog_articles/new.json
  def new
    @blog_article = BlogArticle.new :author_id => current_user.id

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @blog_article }
    end
  end

  # GET /blog_articles/1/edit
  def edit
    @blog_article = BlogArticle.find(params[:id])
  end

  # POST /blog_articles
  # POST /blog_articles.json
  def create
    @blog_article = BlogArticle.new(params[:blog_article])

    respond_to do |format|
      if @blog_article.save
        format.html { redirect_to @blog_article, notice: 'Blog article was successfully created.' }
        format.json { render json: @blog_article, status: :created, location: @blog_article }
      else
        format.html { render action: "new" }
        format.json { render json: @blog_article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /blog_articles/1
  # PUT /blog_articles/1.json
  def update
    @blog_article = BlogArticle.find(params[:id])

    respond_to do |format|
      if @blog_article.update_attributes(params[:blog_article])
        format.html { redirect_to @blog_article, notice: 'Blog article was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @blog_article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blog_articles/1
  # DELETE /blog_articles/1.json
  def destroy
    @blog_article = BlogArticle.find(params[:id])
    @blog_article.destroy

    respond_to do |format|
      format.html { redirect_to blog_articles_url }
      format.json { head :no_content }
    end
  end
end
