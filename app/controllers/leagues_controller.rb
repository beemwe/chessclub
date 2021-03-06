class LeaguesController < ApplicationController
  before_filter :accessible_roles, :only => [:new, :edit, :show, :update, :create]
  load_and_authorize_resource :only => [:new, :create, :destroy,:edit, :update]

  # GET /leagues
  # GET /leagues.json
  def index
    @leagues = League.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @leagues }
    end
  end

  # GET /leagues/1
  # GET /leagues/1.json
  def show
    @league = League.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @league }
    end
  end

  # GET /leagues/new
  # GET /leagues/new.json
  def new
    # @league = League.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @league }
    end
  end

  # GET /leagues/1/edit
  def edit
    # @league = League.find(params[:id])
  end

  # POST /leagues
  # POST /leagues.json
  def create
    # @league = League.new(params[:league])
    @league.kick_off = params[:kick_off] if params[:kick_off]
    @league.durance = params[:durance] if params[:durance]

    respond_to do |format|
      if @league.save
        format.html { redirect_to @league, notice: 'League was successfully created.' }
        format.json { render json: @league, status: :created, location: @league }
      else
        format.html { render action: 'new' }
        format.json { render json: @league.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /leagues/1
  # PUT /leagues/1.json
  def update
    # @league = League.find(params[:id])
    @league.kick_off = params[:kick_off] if params[:kick_off]
    @league.durance = params[:durance] if params[:durance]

    team_player_attrs = params[:team_players_attributes]
    if team_player_attrs.present?
      team_player_attrs.each_with_index do |tp, idx|

      end
    end

    if params[:commit] == 'Speichern & Mannschaftsmeldung'
      @league.finish_preparation!
    end

    if params[:commit] == 'Speichern & Rundenplan'
      @league.finish_announcement!
    end

    if params[:commit] == 'Speichern & Saisonbeginn'
      @league.start_season!
    end

    respond_to do |format|
      if @league.update_attributes(params[:league])
        format.html { redirect_to @league, notice: 'League was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @league.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leagues/1
  # DELETE /leagues/1.json
  def destroy
    # @league = League.find(params[:id])
    @league.destroy

    respond_to do |format|
      format.html { redirect_to leagues_url }
      format.json { head :no_content }
    end
  end

  protected

  def accessible_roles
    @accessible_roles = League.accessible_by(current_ability,:read)
  end


end
