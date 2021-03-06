# encoding: utf-8
class TeamsController < ApplicationController
  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.actives.order(:name)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @teams }
    end
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    @team = Team.find(params[:id])
    # @team_player = @team.league.get_all_team_player(@team.id)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @team }
    end
  end

  # GET /teams/new
  # GET /teams/new.json
  def new
    @team = Team.new
    @team.events.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @team }
    end
  end

  # GET /teams/1/edit
  def edit
    @team = Team.find(params[:id])
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(params[:team])

    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Die Mannschaft wurde erfolgreich erstellt.' }
        format.json { render json: @team, status: :created, location: @team }
      else
        format.html { render action: "new" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /teams/1
  # PUT /teams/1.json
  def update
    @team = Team.find(params[:id])

    respond_to do |format|
      if @team.update_attributes(params[:team])
        format.html { redirect_to @team, notice: 'Die Mannschaftsdaten wurden erfolgreich geändert.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team = Team.find(params[:id])
    @team.destroy

    respond_to do |format|
      format.html { redirect_to teams_url }
      format.json { head :no_content }
    end
  end

  def announce_team
    @team = Team.find(params[:id])
    @team.announce_team
    @team.save

    respond_to do |format|
      format.html { redirect_to teams_url }
      format.json { head :no_content }
    end
  end

  def show_combat_report
    @combat = Combat.find params[:combat_id]
  end

  def edit_combat_report
    @combat = Combat.find params[:combat_id]
    @team_id =  params[:id]
  end

  def update_combat_report
    @combat = Combat.find params[:combat_id]
    @team = Team.find params[:id]
    respond_to do |format|
      if @combat.update_attributes(params[:combat]) && @team.league.save
        format.html do
          flash[:notice] = 'Der Mannschaftskampf wurde erfolgreich gespeichert.'
          redirect_to team_path(@team.id, anchor: "combatday-#{@combat.combatday_id}")
        end
        format.json { head :no_content }
      else
        format.html { redirect_to @team, error: 'Der Mannschaftskampf konnte nicht gespeichert werden.' }
        format.json { render json: @combat.errors, status: :unprocessable_entity }
      end
    end
  end
end
