require 'sinatra'

set :bind, '0.0.0.0'

get '/' do
  'How you doing?'
end

get '/health' do
end
