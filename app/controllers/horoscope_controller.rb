class HoroscopeController < ApplicationController
  def test
    json_response = get_horoscope
    todays_horoscope = json_response["horoscopo"]
    @signs_data = extract_information(todays_horoscope)
  end

  private
  def get_horoscope
    response = RestClient.get 'https://api.xor.cl/tyaas/'
    json = JSON.parse response
  end

  def extract_information(todays_horoscope)
    signs_data = []
    todays_horoscope.each do |sign, values|
      sign_data = {love: values["amor"], health: values["salud"], money: values["dinero"], color: values["color"], number: values["numero"]}
      signs_data.append(sign_data)
    end
    signs_data.shuffle
  end
end
