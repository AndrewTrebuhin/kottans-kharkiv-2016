require 'rubygems'
require 'sinatra'
require 'data_mapper'
require 'digest/md5'
require 'attr_encrypted'
require './env' if File.exists?('env.rb')

DataMapper.setup(:default, ENV['DATABASE_URL'] || 'sqlite:./db/base.db')

class Message
  include DataMapper::Resource
  property :id, Serial
  property :url, String, default: -> r, p { r.make_safe }
  property :visits, Integer, default: 0
  property :delete_after, Integer
  property :encrypted_body, Text
  property :encrypted_body_iv, Text

  attr_encrypted :body, key: ENV['SECRET_KEY'] # aes-256-gcm

  def make_safe
    Digest::MD5.hexdigest(Time.now.to_s + self.id.to_s + self.body)
  end
end

DataMapper.finalize
DataMapper.auto_upgrade!

get '/' do
  erb :new
end

get '/messages' do
  @messages = Message.all
  erb :'index'
end

get '/messages/new' do
  erb :'new'
end

post '/messages/new' do
  params.delete 'submit'
  @message = Message.create(params)
  erb :'show_link'
end

get '/message/:url' do
  if @message = Message.first(url: params[:url])
    @message.visits += 1
    @message.save
    erb :'show'
  else
    'Message isn\'t found!'
  end
end

after '/message/:url'  do
  if @message
    @message.destroy if @message.visits >= @message.delete_after
  end
end