Rails.application.routes.draw do
  get 'horoscope/test'
  post 'horoscope/evaluate', to: 'horoscope#evaluate', as: 'evaluate_test_results'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
