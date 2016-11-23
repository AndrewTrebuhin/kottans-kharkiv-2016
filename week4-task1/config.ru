require "./app"

use Rack::Reloader

map '/' do
  run NewMessage.new
end
