require "active_record"
ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3',
  database: 'development.sqlite3'
)

class SDMessage
  attr_reader :request

  def initialize(request)
    @request = request
  end

  def status
    if exist?
      200
    else
      404
    end
    #201 Created
  end

  def headers
    {'Content-Type' => 'text/html', 'Content-Length' => body.size.to_s}
  end

  def body
    content = if exist?
      "Hello, I'm a homepage!"
      #@request.env.inspect
    else
      'Page not found'
    end

    layout(content)
  end

  private

    def exist?
      request.path_info == '/'
    end

    def layout(content)
      %{<!DOCTYPE html>
          <head>
            <meta charset="utf-8">
            <title>EncMessage</title>
          </head>
          <body>
            #{content}
          </body>
        </html>}
    end
end

class SDMessage::Rack
  def call(env)
    request = Rack::Request.new(env)
    my_app = SDMessage.new(request)

    [my_app.status, my_app.headers, [my_app.body]]
  end
end