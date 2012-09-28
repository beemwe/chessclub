class TournamentsController < ApplicationController
  before_filter :accessible_roles, :only => [:new, :edit, :show, :update, :create]
  load_and_authorize_resource :only => [:new, :create, :destroy,:edit,:update]

  def index
    @tournaments = Tournament.all
    respond_to do |format|
      format.json { render :json => @tournaments }
      format.xml  { render :xml => @tournaments }
      format.js   { render :text => "alert('Hallo!';"}
      format.html
    end
  end

  def show
    @tournament = Tournament.find params[:id]
    respond_to do |format|
      format.json { render :json => @tournament }
      format.xml  { render :xml => @tournament }
      format.html
    end
  end

  def new
    respond_to do |format|
      format.json { render :json => @tournament }
      format.xml  { render :xml => @tournament }
      format.html
    end
  end

  def edit
    respond_to do |format|
      format.json { render :json => @tournament }
      format.xml  { render :xml => @tournament }
      format.html
    end
  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:json, :xml, :html)
  end

  def create
    @tournament = Tournament.new(params[:tournament])

    if @tournament.save
      respond_to do |format|
        format.json { render :json => @tournament.to_json, :status => 200 }
        format.xml  { head :ok }
        format.html { redirect_to(:action => :index, :notice => t('activemodel.notice.create', :model => Tournament.model_name.human)) }
      end
    else
      respond_to do |format|
        format.json { render :text => "Could not create tournament", :status => :unprocessable_entity } # placeholder
        format.xml  { head :ok }
        format.html {
          flash.alert = t('activemodel.notice.could_not_create', :model => Tournament.model_name.human)
          render :action => :new, :status => :unprocessable_entity
        }
      end
    end
  end

  def update
    if @tournament.update_attributes params[:tournament]
      respond_to do |format|
        format.json { render :json => @tournament }
        format.xml  { render :xml => @tournament }
        format.html do
          redirect_to({:action => :show}, :notice => t('activemodel.notice.update', :model => Tournament.model_name.human))
          end
      end
    else
      respond_to do |format|
        format.json { render :text => "Could not create tournament", :status => :unprocessable_entity } # placeholder
        format.xml  { head :ok }
        format.html do
          flash.alert = t('activemodel.notice.could_not_update', :model => Tournament.model_name.human)
          render :action => :edit, :status => :unprocessable_entity
        end
      end
    end
  end

  def destroy
    @tournament.destroy

    respond_to do |format|
      format.json { respond_to_destroy(:ajax) }
      format.xml  { head :ok }
      format.html { redirect_to :action => :index, :notice => t('activemodel.notice.destroy', :model => Tournament.model_name.human) }
    end

  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:json, :xml, :html)
  end

  protected

  def accessible_roles
    @accessible_roles = Role.accessible_by(current_ability,:read)
  end

end
