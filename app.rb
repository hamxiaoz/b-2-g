require 'sinatra'
require 'json'

get '/' do
  'Hello world!'
end

post '/commits' do
  # TODO
  puts JSON.parse(request.body.read()).to_s
end