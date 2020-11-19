class GetHoroscope < PowerTypes::Command.new()
  def perform
    response = RestClient.get 'https://api.xor.cl/tyaas/'
    json = JSON.parse response
    todays_horoscope = json["horoscopo"]
    date_of_horoscope = json["titulo"]
    return todays_horoscope, date_of_horoscope
  end
end
