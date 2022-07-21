Rails.application.routes.draw do

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  post '/disbursements/search' => 'disbursements#search'
  post '/disbursements/massive' => 'disbursements#massive'
end
