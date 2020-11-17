Rails.application.routes.draw do
  get 'horoscope/test'
  get 'horoscope/results', as: 'results'
  post 'horoscope/evaluate', to: 'horoscope#evaluate', as: 'evaluate_test_results'

  root to: 'horoscope#test'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
