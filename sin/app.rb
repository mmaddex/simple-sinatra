require 'sinatra'

set :bind, '127.0.0.1'

get '/' do
  "How you doing???"
end

get '/env' do
  ENV.to_h.to_s
end

get '/secretfile' do
  file = File.read('/etc/secrets/secret.json')
  data_hash = JSON.parse(file)
  data_hash.to_s
end

get '/api/utility/health' do
  status 304
  "thanks fer #{params['token']}"
end
