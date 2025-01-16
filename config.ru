require './app'

puts "starting APP"
puts "from config - #{ENV['RENDER_INSTANCE_ID']}"
# Set up a trap for SIGTERM
Signal.trap("TERM") do
  puts "Received SIGTERM, shutting down gracefully..."
  # Perform any cleanup here, e.g., closing database connections
  sleep 1 # Simulate cleanup time
  exit 0
end

# Set up a trap for SIGINT (e.g., Ctrl+C)
Signal.trap("INT") do
  puts "Received SIGINT, shutting down gracefully..."
  # Perform any cleanup here
  exit 0
end
run Sinatra::Application
