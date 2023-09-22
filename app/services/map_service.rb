class MapService

  def self.city_coordinates(location)
    get_url("/geocoding/v1/address?location=#{location}")
  end

  private

  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn 
    Faraday.new(url: 'https://www.mapquestapi.com') do |f|
      f.params['key'] = Rails.application.credentials.mapquest[:MAPQUEST_API_KEY]
    end
  end
end