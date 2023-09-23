class Forecast
  attr_reader :id,
              :type,
              :current_weather,
              :daily_weather,
              :hourly_weather

  def initialize(cw, dw, hw)
    @id = nil
    @type = 'forecast'
    @current_weather = cw
    @daily_weather = dw
    @hourly_weather = hw
  end
end