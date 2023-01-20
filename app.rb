require 'sinatra'

#set :bind, '127.0.0.1'

get '/' do
  puts "from / - #{ENV['RENDER_INSTANCE_ID']}"
  "Tudo bem!!?"
end

get '/env' do
  ENV.to_h.to_s
end

get '/secretfile' do
  puts "secretfile"
  file = File.read('/etc/secrets/secret.json')
  data_hash = JSON.parse(file)
  data_hash.to_s
end

get '/writefile' do
  File.write('/opt/render/project/test.it', 'Some glorious content', mode: 'a+')
  readit = File.read('/opt/render/project/test.it')
  puts readit
  readit
end

get '/health' do
  puts "from /health - #{ENV['RENDER_INSTANCE_ID']}"
  status 200
  OK
end

get '/api/utility/health' do
  status 304
  "thanks fer #{params['token']}"
end
