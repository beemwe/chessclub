# encoding : utf-8

class TournamentsController < ApplicationController
  before_filter :accessible_roles, :only => [:new, :edit, :show, :update, :create, :start, :finish, :archive]
  load_and_authorize_resource :only => [:new, :create, :destroy,:edit,:update, :start, :finish, :archive]

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
    @players = @tournament.make_table_array
    respond_to do |format|
      format.json { render :json => @tournament }
      format.xml  { render :xml => @tournament }
      format.html
    end
  end

  def start
    @tournament.run!
    redirect_to action: :edit
  end

  def finish
    @tournament.finish!
    redirect_to action: :show
  end

  def archive
    @tournament.archive!
    redirect_to action: :show
  end

  def new
    respond_to do |format|
      format.json { render :json => @tournament }
      format.xml  { render :xml => @tournament }
      format.html
    end
  end

  def edit
    if @tournament.state == 'running'
      @players = @tournament.make_table_array
    end
    respond_to do |format|
      format.json { render :json => @tournament }
      format.xml  { render :xml => @tournament }
      format.html
  end

  def edit_result
    @tournament = Tournament.find params[:id]
    @player1 = TournamentPlayer.find params[:white]
    @player2 = TournamentPlayer.find params[:black]
    @row = params[:row]
    @col = params[:col]
    @point1 = 'x'
    @point2 = 'x'
    if params[:result] == '1:0'
      @point1 = '1'
      @point2 = '0'
      @player1.add_game_result @player2.id, 1
      @player2.add_game_result @player1.id, 0
    elsif params[:result] == '0:1'
        @point1 = '0'
        @point2 = '1'
        @player1.add_game_result @player2.id, 0
        @player2.add_game_result @player1.id, 1
    elsif params[:result] == 'remis'
        @point1 = '½'
        @point2 = '½'
        @player1.add_game_result @player2.id, 0.5
        @player2.add_game_result @player1.id, 0.5
    elsif params[:result] == '1:0 kl'
        @point1 = '1 kl'
        @point2 = '0 kl'
        @player1.add_game_result @player2.id, 1
        @player2.add_game_result @player1.id, 0
    elsif params[:result] == '0:1 kl'
        @point1 = '0 kl'
        @point2 = '1 kl'
        @player1.add_game_result @player2.id, 0
        @player2.add_game_result @player1.id, 1
    elsif params[:result] == '0:0'
        @point1 = '–'
        @point2 = '–'
        @player1.add_game_result @player2.id, 0
        @player2.add_game_result @player1.id, 0
    end
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
