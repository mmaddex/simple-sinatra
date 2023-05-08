require 'sinatra'

#set :bind, '127.0.0.1'

get '/' do
  puts "from / - #{ENV['RENDER_INSTANCE_ID']}"
  "Tudo bem??~"
end

get '/itsa/:status_code' do
  status params[:status_code].to_i
end

get '/env' do
  response.headers['Transfer-Encoding'] = 'gzip'
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
  puts "Health check reqeuest from - #{ENV['RENDER_INSTANCE_ID']} - #{request.url}"
  status 200
  "orl korrect"
end

get '/healthfail' do
  puts "from /health - #{ENV['RENDER_INSTANCE_ID']}"
  status 500
  "none korrect"
end

get '/api/utility/health' do
  status 304
  "thanks fer #{params['token']}"
end
