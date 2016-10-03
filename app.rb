require 'rubygems'
require 'sinatra'
require 'dm-core'
require 'data_mapper'

DataMapper.setup(:default, ENV['DATABASE_URL'] || 'sqlite:./db/base.db')

class Message
  include DataMapper::Resource
  property :id, Serial
  property :body, Text
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

get '/message/:id' do
  @message = Message.get(params[:id])
  erb :'show'
end