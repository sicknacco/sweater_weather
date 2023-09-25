class RoadTrip
  attr_reader :id,
              :type,
              :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta
              
  def initialize(origin, destination, formatted_trvl_time, arrival_forecast)
    @id = nil
    @type = 'roadtrip'
    @start_city = origin
    @end_city = destination
    @travel_time = formatted_trvl_time
    @weather_at_eta = arrival_forecast
  end
end