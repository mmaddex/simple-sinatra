require './app'

begin
  run Sinatra::Application
rescue SignalException => e
  puts "Received Signal #{e}"
  puts 'shutting down'
end
