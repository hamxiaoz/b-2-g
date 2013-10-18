# require 'sinatra/base'
require 'sinatra'
require 'json'
require 'cgi'
require 'octokit'
# require 'figaro'

# class Application < Sinatra::Base
get '/' do
  'Hi'
end

REPO = "hamxiaoz/bitbucket-activity"
LOG_FILE = "log"

post '/commits' do
  # payload format
  # https://confluence.atlassian.com/display/BITBUCKET/POST+hook+management
  # The payload has payload= prepended to the actual payload. 
  # The payload is url encode content.
  json = JSON.parse(CGI.unescape(request.body.read().sub(/^payload=/, "")))
  msg = json['commits'].map do |c|
        # obfuscate message with '*'
        obfuscated = c['message'].gsub /[^\n\r]/, "*"
        "#{c['utctimestamp']}, #{obfuscated}"
        end.join
  puts msg

  # replace file content with msg and commit with msg
  # client = Octokit::Client.new ENV['ACCESS_TOKEN']
  # sha = client.contents(REPO, :path => LOG_FILE)[:sha]
  # client.update_contents(REPO, LOG_FILE, msg, sha, msg)
end

# if Application.settings.development?
#   # figaro with sinatra, see https://github.com/laserlemon/figaro/issues/60
#   module Figaro
#     def path
#       @path ||= File.join(Application.settings.root, "config", "application.yml")
#     end

#     def environment
#       Application.settings.environment
#     end
#   end

#   Figaro.env.each do |key, value|
#     ENV[key] = value unless ENV.key?(key)
#   end
# end