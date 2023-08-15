require 'sinatra'

get '/' do
  puts "from / - #{ENV['RENDER_INSTANCE_ID']}"
  "NOW WITH BROKEN BLUEPRINTS"
end

get '/itsa/:status_code' do
  status params[:status_code].to_i
end

get '/env' do
  ENV.to_h.to_s
end

get '/appfile' do
  puts "appfile"
  file = File.read('/opt/render/project/src/run.sh')
  file.to_s
end

get '/secretfile' do
  puts "secretfile"
  file = File.read('/etc/secrets/secret.json')
  # data_hash = JSON.parse(file)
  # data_hash.to_s
  file.to_s
end

get '/rootsecretfile' do
  puts "secretfile"
  file = File.read('secret.json')
  # data_hash = JSON.parse(file)
  # data_hash.to_s
  file.to_s
end

get '/dotrootsecretfile' do
  puts "secretfile"
  file = File.read('./secret.json')
  # data_hash = JSON.parse(file)
  # data_hash.to_s
  file.to_s
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
