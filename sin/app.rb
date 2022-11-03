require 'sinatra'

set :bind, '127.0.0.1'

get '/' do
  "How you doing?"
end

get '/api/utility/health' do
  status 304
  "thanks fer #{params['token']}"
end
