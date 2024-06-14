require './app'

puts "starting APP"
puts "from config - #{ENV['RENDER_INSTANCE_ID']}"
run Sinatra::Application
