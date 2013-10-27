class OrganizationPlayersController < ApplicationController
  # GET /organization_players
  # GET /organization_players.json
  def index
    @organization_players = OrganizationPlayer.order(:last_name, :first_name).page(params[:page]).per(15)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @organization_players }
    end
  end

  # GET /organization_players/1
  # GET /organization_players/1.json
  def show
    @organization_player = OrganizationPlayer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @organization_player }
    end
  end

  # GET /organization_players/new
  # GET /organization_players/new.json
  def new
    @organization_player = OrganizationPlayer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @organization_player }
    end
  end

  # GET /organization_players/1/edit
  def edit
    @organization_player = OrganizationPlayer.find(params[:id])
  end

  # POST /organization_players
  # POST /organization_players.json
  def create
    @organization_player = OrganizationPlayer.new(params[:organization_player])
    if @organization_player.save
      page = (@organization_player.id % 15) + 1
      respond_to do |format|
        format.html { redirect_to organization_players_path(page: page), notice: 'League was successfully created.' }
        format.json { render json: @organization_player, status: :created, location: @organization_player }
      end
    else
      respond_to do |format|
        format.html { render action: 'new' }
        format.json { render json: @organization_player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /leagues/1
  # PUT /leagues/1.json
  def update
    @organization_player = OrganizationPlayer.find(params[:id])
    page = (@organization_player.id % 15) + 1
    respond_to do |format|
      if @organization_player.update_attributes(params[:league])
        format.html { redirect_to organization_players_path(page: page), notice: 'OrganizationPlayer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @organization_player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leagues/1
  # DELETE /leagues/1.json
  def destroy
    @organization_player = OrganizationPlayer.find(params[:id])
    @organization_player.destroy

    respond_to do |format|
      format.html { redirect_to organization_players_path }
      format.json { head :no_content }
    end
  end
end
