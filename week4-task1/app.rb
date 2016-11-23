class NewMessage

  def call(env)
    [200, {"Content-Type" => "text/html"}, ["<h1>New Message</h2>", env.inspect]]
  end
end