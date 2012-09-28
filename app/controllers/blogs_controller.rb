class BlogsController < ApplicationController
  load_and_authorize_resource :blog, :except => [:show]
  # skip_authorize_resource :only => :show

  # GET /blogs
  # GET /blogs.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @blogs }
    end
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
    @blog = Blog.find params[:id]
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @blog }
    end
  end

  # GET /blogs/new
  # GET /blogs/new.json
  def new
    @blog = Blog.new(:author_id => current_user.id)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @blog }
    end
  end

  # GET /blogs/1/edit
  def edit
    # @blog = Blog.find_by_permalink(params[:id])
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = Blog.new(params[:blog])
    @blog.author_id = current_user.id

    respond_to do |format|
      if @blog.save
        format.html { (redirect_to @blog, :notice => t('activemodel.notice.create', :model => Blog.model_name.human)) }
        format.json { render json: @blog, status: :created, location: @blog }
      else
        format.html { render action: "new" }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /blogs/1
  # PUT /blogs/1.json
  def update
    # @blog = Blog.find_by_permalink(params[:id])
    old_permalink = @blog.permalink

    @blog.title = params[:content][:blog_title][:value] if params[:content] && params[:content][:blog_title][:value]
    @blog.subtitle = params[:content][:blog_subtitle][:value] if params[:content] && params[:content][:blog_subtitle][:value]
    @blog.content = params[:content][:blog_content][:value] if params[:content] && params[:content][:blog_content][:value]

    respond_to do |format|
      if @blog.update_attributes(params[:blog])
        format.html { (redirect_to @blog, :notice => t('activemodel.notice.update', :model => Blog.model_name.human)) }
        format.json { head :no_content }
      else
        format.html do
          @blog.permalink = old_permalink
          flash.alert = t('activemodel.notice.could_not_update', :model => Blog.model_name.human)
          render :action => :edit, :status => :unprocessable_entity
        end
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog.destroy

    respond_to do |format|
      format.html { redirect_to blogs_url }
      format.json { head :no_content }
    end
  end

  def mercury_update
    @blog = Blog.find_by_permalink(params[:id])
    old_permalink = @blog.permalink

    @blog.title = params[:content][:blog_title][:value]
    @blog.content = params[:content][:blog_content][:value]

    if @blog.save
      flash.notice = "Update erfolgreich!"
      render text: ""
    else
      @blog.permalink = old_permalink
      flash.alert = t('activemodel.notice.could_not_update', :model => Blog.model_name.human)
      render text: ""
    end
  end
end
