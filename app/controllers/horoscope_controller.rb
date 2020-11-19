class HoroscopeController < ApplicationController
  def test
    @date_of_horoscope, @signs_data, @signs_list, @select_list  = PreprocessData.for()
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
