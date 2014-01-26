class Api::V1::LeaguesController  < ApplicationController
  respond_to :json

  load_and_authorize_resource

  def index
    @leagues = League.where(state: 'execution')

    if request.format != :json
      render :status=>406, :json=>{:message=>'The request must be json'}
      return
    end
  end

  def show
    @league = League.find(params[:id])

    @teams = @league.get_ranked_teams

    if request.format != :json
      render :status=>406, :json=>{:message=>'The request must be json'}
      return
    end
  end
end