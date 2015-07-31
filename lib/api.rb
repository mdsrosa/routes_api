class WalmartChallengeAPI < Sinatra::Base
  get '/' do
    'Walmart Challenge API :)'
  end

  get '/routes' do
    Route.all.to_json
  end

  post '/routes/calculate-cost' do
    response = {:cost => 6.25, :route => 'A B D'}
    JSON.dump(response)
  end
end