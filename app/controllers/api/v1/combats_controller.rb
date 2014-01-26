class Api::V1::CombatsController  < ApplicationController
  respond_to :json

  load_and_authorize_resource

  def index
    @combats = Combat.find_open_combats

    if request.format != :json
      render :status=>406, :json=>{:message=>'The request must be json'}
      return
    end

    render status: 200, json: @combats.to_json
  end
end