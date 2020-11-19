class PreprocessData < PowerTypes::Command.new()
  def perform
    todays_horoscope, date_of_horoscope  = GetHoroscope.for()
    signs_data = extract_information(todays_horoscope)
    signs_list = generate_signs_list
    select_list = generate_select_list(signs_data)
    return date_of_horoscope, signs_data, signs_list, select_list
  end

  private
  def extract_information(todays_horoscope)
    signs_data = []
    current_id = 0
    todays_horoscope.each do |sign, values|
      sign_data = {love: values["amor"], health: values["salud"], money: values["dinero"], id: current_id}
      signs_data.append(sign_data)
      current_id += 1
    end
    signs_data.shuffle
  end

  def generate_signs_list
    all_signs = ["Aries", "Tauro", "Géminis", "Cáncer", "Leo", "Virgo", "Libra", "Escorpión",
      "Sagitario", "Capricornio", "Acuario", "Piscis"]
    all_signs.map.with_index { |sign, idx| [sign, idx] }
  end

  def generate_select_list(signs_data)
    signs_data.map.with_index { |sign_data, idx| [idx + 1, sign_data[:id]] }
  end
end
