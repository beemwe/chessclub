# encoding:utf-8
class UsersController < ApplicationController
  before_filter :get_user, :only => [:index,:new,:edit]
  before_filter :accessible_roles, :only => [:new, :edit, :show, :update, :create]
  load_and_authorize_resource :only => [:show,:new,:destroy,:edit,:update]
 
  # GET /users
  # GET /users.xml                                                
  # GET /users.json                                       HTML and AJAX
  #-----------------------------------------------------------------------
  def index
    params[:selection_type] ||= session[:user_sel_type]
    session[:user_sel_type] = params[:selection_type]
    params[:page] ||= session[:user_sel_page]
    session[:user_sel_page] = params[:page]
    case params[:selection_type]
      when 'players'
        @users = User.player.accessible_by(current_ability, :index).order(:last_name, :first_name).page(params[:page]).per(10)
        @sel_type = 2
      when 'members'
        @users = User.member.accessible_by(current_ability, :index).order(:last_name, :first_name).page(params[:page]).per(10)
        @sel_type = 1
      else
        @users = User.accessible_by(current_ability, :index).order(:last_name, :first_name).page(params[:page]).per(10)
        @sel_type = 0
    end
    respond_to do |format|
      format.json { render :json => @users }
      format.xml  { render :xml => @users }
      format.js   { render :text => "alert('Hallo!';"}
      format.html
    end
  end
 
  # GET /users/new
  # GET /users/new.xml                                            
  # GET /users/new.json                                    HTML AND AJAX
  #-------------------------------------------------------------------
  def new
    respond_to do |format|
      format.json { render :json => @user }   
      format.xml  { render :xml => @user }
      format.html
    end
  end
 
  # GET /users/1
  # GET /users/1.xml                                                       
  # GET /users/1.json                                     HTML AND AJAX
  #-------------------------------------------------------------------
  def show
    respond_to do |format|
      format.json { render :json => @user }
      format.xml  { render :xml => @user }
      format.html      
    end
 
  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:json, :xml, :html)
  end
 
  # GET /users/1/edit                                                      
  # GET /users/1/edit.xml                                                      
  # GET /users/1/edit.json                                HTML AND AJAX
  #-------------------------------------------------------------------
  def edit
    respond_to do |format|
      format.json { render :json => @user }
      format.xml  { render :xml => @user }
      format.html
    end

  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:json, :xml, :html)
  end
 
  # DELETE /users/1     
  # DELETE /users/1.xml
  # DELETE /users/1.json                                  HTML AND AJAX
  #-------------------------------------------------------------------
  def destroy
    @user.destroy!
 
    respond_to do |format|
      format.json { respond_to_destroy(:ajax) }
      format.xml  { head :ok }
      format.html { respond_to_destroy(:html) }      
    end
 
  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:json, :xml, :html)
  end
 
  # POST /users
  # POST /users.xml         
  # POST /users.json                                      HTML AND AJAX
  #-----------------------------------------------------------------
  def create
    @user = User.new(params[:user])
 
    if @user.save
      respond_to do |format|
        format.json { render :json => @user.to_json, :status => 200 }
        format.xml  { head :ok }
        format.html { redirect_to({:action => params[:commit] == 'User erstellen & Neu' ? :new : :index}, :notice => t('activemodel.notice.create', :model => User.model_name.human)) }
      end
    else
      respond_to do |format|
        format.json { render :text => "Could not create user", :status => :unprocessable_entity } # placeholder
        format.xml  { head :ok }
        format.html {
          flash.alert = t('activemodel.notice.could_not_create', :model => User.model_name.human)
          render :action => :new, :status => :unprocessable_entity
        }
      end
    end
  end

  def update
    if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
      params[:user].except!(:password, :password_confirmation)
    end
    if @user.update_attributes params[:user]
      respond_to do |format|
        format.json { render :json => @user }
        format.xml  { render :xml => @user }
        format.html do
          redirect_to({:action => :index}, :notice => t('activemodel.notice.update', :model => User.model_name.human))
          end
      end
    else
      respond_to do |format|
        format.json { render :text => "Could not create user", :status => :unprocessable_entity } # placeholder
        format.xml  { head :ok }
        format.html do
          flash.alert = t('activemodel.notice.could_not_update', :model => User.model_name.human)
          render :action => :edit, :status => :unprocessable_entity
        end
      end
    end

  end

  protected

  def accessible_roles
    @accessible_roles = Role.accessible_by(current_ability,:read)
  end

  # Make the current user object available to views
  #----------------------------------------
  def get_user
    @current_user = current_user
  end

end