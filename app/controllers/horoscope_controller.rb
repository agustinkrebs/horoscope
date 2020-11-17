class HoroscopeController < ApplicationController
  def test
    json_response = get_horoscope
    todays_horoscope = json_response["horoscopo"]
    @date_of_horoscope = json_response["titulo"]
    @signs_data = extract_information(todays_horoscope)
    @signs_list = [["Aries", 0],["Tauro", 1],["Géminis", 2],["Cáncer", 3],["Leo", 4],["Virgo", 5],["Libra", 6],["Escorpión", 7],["Sagitario", 8],["Capricornio", 9],["Acuario", 10],["Piscis", 11]]
    @select_list = [[1, @signs_data[0][:id]],[2, @signs_data[1][:id]],[3, @signs_data[2][:id]],[4, @signs_data[3][:id]],[5, @signs_data[4][:id]],[6, @signs_data[5][:id]],[7, @signs_data[6][:id]],[8, @signs_data[7][:id]],[9, @signs_data[8][:id]],[10, @signs_data[9][:id]],[11, @signs_data[10][:id]],[12, @signs_data[11][:id]]]
  end

  def evaluate
    real_sign_id = params[:sign_id]
    guesses_sign_id = [params[:card_id1], params[:card_id2], params[:card_id3]]
    guesses = Guess.find_by_id(1)
    if !guesses
      @guess = Guess.new(total_guesses: 0, correct_guesses: 0)
      @guess.save
      guesses = Guess.find_by_id(1)
    end
    if guesses_sign_id.include?(real_sign_id)
      guesses.update(total_guesses: guesses.total_guesses + 1, correct_guesses: guesses.correct_guesses + 1)
      guessed_correctly = true
    else
      guesses.update(total_guesses: guesses.total_guesses + 1)
      guessed_correctly = false
    end
    redirect_to(action: 'results', real_sign_id: real_sign_id, guessed_correctly: guessed_correctly)
  end

  def results
    sign_id_to_name = {0=>"aries", 1=>"tauro", 2=>"géminis", 3=>"cáncer", 4=>"leo", 5=>"virgo", 6=>"libra", 7=>"escorpión", 8=>"sagitario", 9=>"capricornio", 10=>"acuario", 11=>"piscis"}
    @sign_name = sign_id_to_name[params[:real_sign_id].to_i]
    @sign_data= get_horoscope_of_one_sign(@sign_name)
    if params[:guessed_correctly]
      @status = "incorrecta"
    else
      @status = "correcta"
    end
    @guesses = Guess.find_by_id(1)
    @expected_random_correct = 3/12.to_f * 100
    @real_result = @guesses.correct_guesses/@guesses.total_guesses.to_f * 100

  end

  private

  def get_horoscope_of_one_sign(sign_name)
    horoscope = get_horoscope
    sign_horoscope = horoscope["horoscopo"][sign_name]
    sign_data = {love: sign_horoscope["amor"], health: sign_horoscope["salud"], money: sign_horoscope["dinero"]}
  end

  def get_horoscope
    response = RestClient.get 'https://api.xor.cl/tyaas/'
    json = JSON.parse response
  end

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
end
