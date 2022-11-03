require 'sinatra'

set :bind, '0.0.0.0'

get '/' do
  "How you doing?"
end

get '/api/utility/health' do
  status 304
  "thanks fer #{params['token']}"
end
