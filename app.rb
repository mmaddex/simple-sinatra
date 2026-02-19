require 'sinatra'
require 'json'
require 'puma'

class UrlSchemeLogger
  def initialize(app)
    @app = app
  end

  def call(env)
    original_scheme = env['rack.url_scheme']
    puts "[UrlSchemeLogger] rack.url_scheme before stack: #{original_scheme.inspect}"
    @app.call(env)
  end
end

use UrlSchemeLogger
# Set up a trap for SIGTERM
Signal.trap("TERM") do
  puts "Received SIGTERM, shutting down gracefully..."
  # Perform any cleanup here, e.g., closing database connections
  sleep 5 # Simulate cleanup time
  exit 0
end

# Set up a trap for SIGINT (e.g., Ctrl+C)
Signal.trap("INT") do
  puts "Received SIGINT, shutting down gracefully..."
  # Perform any cleanup here
  exit 0
end

get '/' do
  cache_control :public, :must_revalidate, max_age: ENV['MAX_AGE']
  # headers['Cache-Control'] += ", stale-while-revalidate=#{ENV['STALE']}"
  "Native Runtime: Tudo bem?\n\n#{Time.now.to_i}\n\n#{request.url}\n\n#{ENV['RENDER_INSTANCE_ID']}"
end

post '/test' do
  STDERR.puts "errrrrr"
  STDOUT.puts "ooooot"
  "thats nice"
end

get '/header/:val' do
  puts "Host header: #{request.host}"
  puts "#{params[:val]} header is #{request.send params[:val]}"
  "#{params[:val]} header is #{request.send params[:val]}"
end

get '/itsa/:status_code' do
  status params[:status_code].to_i
end

get '/headers' do
  headers = request.env.select { |k, v| k.start_with?('HTTP_') }
  headers.map { |k, v| "#{k}: #{v}" }.join("\n")
end

get '/withresponseheaders' do
  response.headers['x-test'] = 'matts header'
  response.headers['accept-ranges'] = 'bytes'
  'testing this out'
end

get '/env' do
  ENV.to_h.to_s
end

get '/request' do
  STDOUT.puts request
  request
end

get '/info' do
  e = {"level":"info","service":"event-service","env":"sandbox","error":"Failed to fetch user details","stack":"Error: Failed to fetch user details\n    at https://sandbox.modules-7bj.pages.dev/assets/overlay-D3o9D5Es.js:3:17793","req_id":"","referer":"https://sandbox.modules-7bj.pages.dev/","origin":"https://sandbox.modules-7bj.pages.dev","user_agent":"Mozilla/5.0 (iPhone; CPU iPhone OS 16_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6 Mobile/15E148 Safari/604.1","meta":{"lang":"","market":""},"time":"2024-03-08T12:10:52Z","message":"error"}
  puts e.to_json
  JSON.pretty_generate(e)
end

get '/warning' do
  e = {"level":"warning","service":"event-service","env":"sandbox","error":"Failed to fetch user details","stack":"Error: Failed to fetch user details\n    at https://sandbox.modules-7bj.pages.dev/assets/overlay-D3o9D5Es.js:3:17793","req_id":"","referer":"https://sandbox.modules-7bj.pages.dev/","origin":"https://sandbox.modules-7bj.pages.dev","user_agent":"Mozilla/5.0 (iPhone; CPU iPhone OS 16_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6 Mobile/15E148 Safari/604.1","meta":{"lang":"","market":""},"time":"2024-03-08T12:10:52Z","message":"error"}
  puts e.to_json
  JSON.pretty_generate(e)
end

get '/error' do
  e = {"level":"error","service":"event-service","env":"sandbox","error":"Failed to fetch user details","stack":"Error: Failed to fetch user details\n    at https://sandbox.modules-7bj.pages.dev/assets/overlay-D3o9D5Es.js:3:17793","req_id":"","referer":"https://sandbox.modules-7bj.pages.dev/","origin":"https://sandbox.modules-7bj.pages.dev","user_agent":"Mozilla/5.0 (iPhone; CPU iPhone OS 16_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6 Mobile/15E148 Safari/604.1","meta":{"lang":"","market":""},"time":"2024-03-08T12:10:52Z","message":"error"}
  puts e.to_json
  JSON.pretty_generate(e)
end

get '/appfile' do
  STDOUT.puts "appfile"
  file = File.read('/opt/render/project/src/run.sh')
  file.to_s
end

get '/secretfile' do
  STDOUT.puts "secretfile"
  file = File.read('/etc/secrets/secret.json')
  # data_hash = JSON.parse(file)
  # data_hash.to_s
  file.to_s
end

get '/rootsecretfile' do
  STDOUT.puts "secretfile"
  file = File.read('secret.json')
  # data_hash = JSON.parse(file)
  # data_hash.to_s
  file.to_s
end

get '/dotrootsecretfile' do
  STDOUT.puts "secretfile"
  file = File.read('./secret.json')
  # data_hash = JSON.parse(file)
  # data_hash.to_s
  file.to_s
end

get '/writefile' do
  File.write('/opt/render/project/test.it', 'Some glorious content', mode: 'a+')
  readit = File.read('/opt/render/project/test.it')
  STDOUT.puts readit
  readit
end

get '/health' do
  puts "SECOND HOT FIX reqeuest from - #{ENV['RENDER_INSTANCE_ID']} - #{request.url}"
  status 200
  "orl korrect"
end

get '/healthfail' do
  puts "from /healthfail - #{ENV['RENDER_INSTANCE_ID']} at #{Time.now.min} minute"
  puts Time.now.min%4 != 1
  if Time.now.min%4 != 1
    status 429
    "none korrect"
  else
    status 200
    "korrect four now"
  end
end

get '/threadhealth' do
  puma_stats = Puma.stats
  stats = JSON.parse(puma_stats)
  workers_count = stats['workers'] || 1
  total_threads = stats['worker_status'].sum { |worker| worker['last_status']['max_threads'] }
  puts puma_stats
  puts "#{workers_count} workers"
  puts "#{total_threads} threads"
  if workers_count < 3
    status 400
    "none korrect"
  else
    status 200
    "korrect four now"
  end
end

get '/healthtimeout' do
  puts "timing out /healthtimeout - #{ENV['RENDER_INSTANCE_ID']} at #{Time.now.min} minute" 
  puts Time.now.min%5 != 1
  if Time.now.min%5 != 1
    puts 'wait for it'
    sleep 10
    puts 'awake!'
    status 400
    "delayed not korrect"
  else
    puts 'instant!'
    status 200
    "korrect four now"
  end
end

get '/api/utility/health' do
  status 304
  "thanks fer #{params['token']}"
end

get '/cert' do
  tls_keys = %w[
    SSL_CLIENT_CERT
    SSL_CLIENT_S_DN
    SSL_CLIENT_I_DN
    SSL_CLIENT_VERIFY
    SSL_SERVER_CERT
    SSL_SERVER_S_DN
    SSL_CIPHER
    SSL_PROTOCOL
    SSL_SESSION_ID
    HTTPS
    HTTP_X_FORWARDED_PROTO
    HTTP_X_FORWARDED_SSL
    HTTP_X_SSL_CLIENT_CERT
    HTTP_X_SSL_CLIENT_VERIFY
    HTTP_X_SSL_CIPHER
    HTTP_X_SSL_PROTOCOL
    puma.ssl_cipher
    puma.ssl_protocol
    REQUEST_URI
    HTTP_HOST
    rack.url_scheme
  ]

  tls_info = tls_keys.each_with_object({}) do |key, h|
    val = request.env[key]
    h[key] = val if val
  end

  content_type :text
  if tls_info.empty?
    "No TLS information found in request.\n"
  else
    tls_info.map { |k, v| "#{k}: #{v}" }.join("\n") + "\n"
  end
end
