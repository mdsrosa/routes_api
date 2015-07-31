class WalmartChallengeAPI < Sinatra::Base
  get '/' do
    Route.all.to_json
  end
end