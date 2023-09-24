class Api::V0::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    if user
      road_trip = RoadTripFacade.get_trip(params[:origin], params[:destination])
      render json: RoadTripSerializer.new(road_trip), status: 201
    else
      render json: { error: 'Invalid API key' }, status: 401
    end
  end
end