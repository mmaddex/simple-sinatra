require 'sinatra'
require 'json'

get '/' do
  STDERR.puts "errrrrr"
  STDOUT.puts "ooooot"
  puts "from / - #{ENV['RENDER_INSTANCE_ID']}"
  "Tudo bem?!??!!!?"
end

get '/header' do
  puts "Host header: #{request.host}"
  puts "x-forwarded-proto: #{request['x-forwarded-proto']}"
  puts "X-Forwarded-Proto: #{request['X-Forwarded-Proto']}"
  "X-Forwarded-Proto: #{request['X-Forwarded-Proto']}"
end

get '/itsa/:status_code' do
  status params[:status_code].to_i
end

get '/env' do
  ENV.to_h.to_s
end

get '/request' do
  puts request
  request
end

get '/json' do
  puts 'JSON'
  puts ({test: 'error json', level: 'info', out: {with: [1,2]}}.to_json)
  puts 'HASH'
  puts ({test: 'warning hash', level: 'info', out: {with: [1,2]}})
  puts 'pretty'
  puts JSON.pretty_generate({test: 'info pretty', out: {with: [1,2]}})
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
  puts "from /healthfail - #{ENV['RENDER_INSTANCE_ID']} at #{Time.now.min} minute"
  puts Time.now.min%2 == 1
  if Time.now.min%2 == 1
    status 500
    "none korrect"
  else
    status 200
    "korrect four now"
  end
end

get '/healthtimeout' do
  puts "timing out /healthtimeout - #{ENV['RENDER_INSTANCE_ID']} at #{Time.now.min} minute" 
  puts Time.now.min%2 == 1
  if Time.now.min%2 == 1
    sleep 15
    status 200
    "delayed korrect"
  else
    status 200
    "korrect four now"
  end
end

get '/api/utility/health' do
  status 304
  "thanks fer #{params['token']}"
end
