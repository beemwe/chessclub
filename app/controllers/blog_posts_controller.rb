# encoding: utf-8
class BlogPostsController < ApplicationController
  load_and_authorize_resource :blog_post, :except => [:index, :show, :get_files]
  before_filter :parse_raw_upload, only: :add_files

  # GET /blog_posts
  # GET /blog_posts.json
  def index
    @blog_posts = BlogPost.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @blog_posts }
    end
  end

  # GET /blog_posts/1
  # GET /blog_posts/1.json
  def show
    @blog_post = BlogPost.find params[:id]
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @blog_post }
    end
  end

  # GET /blog_posts/new
  # GET /blog_posts/new.json
  def new
    @blog_post = BlogPost.new(:author_id => current_user.id)

    respond_to do |format|
      format.html { render action: 'show' }
      format.json { render json: @blog_post }
    end
  end

  # GET /blog_posts/1/edit
  def edit
  end

  # POST /blog_posts
  # POST /blog_posts.json
  def create
    @blog_post = BlogPost.new(params[:blogpost])
    @blog_post.author_id = current_user.id

    respond_to do |format|
      if @blog_post.save
        format.html { (redirect_to @blog_post, :notice => t('activemodel.notice.create', :model => BlogPost.model_name.human)) }
        format.json { render json: @blog_post, status: :created, location: @blog_post }
      else
        format.html { render action: 'new' }
        format.json { render json: @blog_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /blog_posts/1
  # PUT /blog_posts/1.json
  def update
    @blog_post.title = params[:content][:blog_title][:value] if params[:content] && params[:content][:blog_title][:value]
    @blog_post.subtitle = params[:content][:blog_subtitle][:value] if params[:content] && params[:content][:blog_subtitle][:value]
    @blog_post.content = params[:content][:blog_content][:value] if params[:content] && params[:content][:blog_content][:value]

    respond_to do |format|
      if @blog_post.update_attributes(params[:blogpost])
        format.html { (redirect_to @blog_post, :notice => t('activemodel.notice.update', :model => BlogPost.model_name.human)) }
        format.json { head :no_content }
      else
        format.html do
          flash.alert = t('activemodel.notice.could_not_update', :model => BlogPost.model_name.human)
          render :action => :edit, :status => :unprocessable_entity
        end
        format.json { render json: @blog_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blog_posts/1
  # DELETE /blog_posts/1.json
  def destroy
    @blog_post.destroy

    respond_to do |format|
      format.html { redirect_to blog_posts_url }
      format.json { head :no_content }
    end
  end

  def mercury_create
    @blog_post = BlogPost.new(params[:blogpost])
    @blog_post.author_id = current_user.id
    @blog_post.title = params[:content][:blog_title][:value]
    @blog_post.subtitle = params[:content][:blog_subtitle][:value]
    @blog_post.content = params[:content][:blog_content][:value]

    if @blog_post.save
      flash.notice = 'Erstellen erfolgreich!'
      render text: ''
    else
      flash.alert = t('activemodel.notice.could_not_create', :model => BlogPost.model_name.human)
      render text: '', status: 422
    end
  end

  def mercury_update
    @blog_post.title = params[:content][:blog_title][:value]
    @blog_post.subtitle = params[:content][:blog_subtitle][:value]
    @blog_post.content = params[:content][:blog_content][:value]

    if @blog_post.save
      flash.notice = 'Update erfolgreich!'
      render text: ''
    else
      flash.alert = t('activemodel.notice.could_not_update', :model => BlogPost.model_name.human)
      render text: '', status: 422
    end
  end

  def publish
    @blog_post.published_at = Time.now
    if @blog_post.save
      redirect_to action: :index, notice: 'Erfolgreich veröffenlicht!'
    else
      redirect_to action: :index, alert: 'Artikel konnte nicht veröffentlcht werden!'
    end
  end

  def add_files
    @blog_post_file = @blog_post.blog_post_files.build(attachment: @raw_file)
    if @blog_post_file.save
      render js: {'success' => true}
    else
      render js: {'success' => false}
    end
  end

  def get_files
    @blog_post = BlogPost.find params[:id]
  end

  def get_slideshow
    @blog_post = BlogPost.find params[:id]
  end

  private
  def parse_raw_upload
    if env['HTTP_X_FILE_UPLOAD'] == 'true'
      @raw_file = env['rack.input']
      @raw_file.class.class_eval { attr_accessor :original_filename, :content_type }
      @raw_file.original_filename = env['HTTP_X_FILE_NAME']
      @raw_file.content_type = env['HTTP_X_MIME_TYPE']
    end
  end
end
