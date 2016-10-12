require File.expand_path '../spec_helper.rb', __FILE__

describe "My Sinatra Application" do
  it 'should show home page' do
    get '/'
    expect(last_response).to be_ok
  end

  it 'should show messages page' do
    get '/messages'

    expect(last_response.body).to include('<h1>All messages (for test)</h1>')
  end

  it 'should show new message page' do
    get '/messages/new'

    expect(last_response.body).to include('<h2>New message</h2>')
  end

  it 'should create a message' do
    Message.create(url: 'randomurl', delete_after: 3, body: 'Some text')

    get '/message/randomurl'

    expect(last_response.body).to include('<h2>randomurl</h2>')
    expect(last_response.body).to include('Some text')
  end

  it 'should show an error' do
    get '/message/wrongurl'

    expect(last_response.body).to include('Message isn\'t found!')
  end

end