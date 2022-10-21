require 'sinatra'

set :bind, '0.0.0.0'

get '/' do
  "How you doing? #{ENV['test_env']}"
end

get '/health' do
end
