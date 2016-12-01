require "./app"

use Rack::Reloader
use Rack::ShowExceptions

run SDMessage::Rack.new