require 'sinatra'
require 'json'
require 'uri'

get '/' do
  'Hello world!'
end

post '/commits' do
  # payload format
  # https://confluence.atlassian.com/display/BITBUCKET/POST+hook+management
  # The payload has payload= prepended to the actual payload. 
  # The payload is url encode content.
  json = JSON.parse(URI.unescape(request.body.read().sub(/^payload=/, "")))
  puts json.to_s
end