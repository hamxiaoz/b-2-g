require 'sinatra'
require 'json'
require 'cgi'
require 'octokit'

class Application < Sinatra::Base

  configure :development do
    require 'dotenv'
    Dotenv.load
  end

  get '/' do
    ENV['WELCOME_MSG']
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
            obfuscated_msg = c['message'].gsub /[^\n\r]/, "*"
            obfuscated_repo_name = json['repository']['name'].gsub /[A-Za-z0-9]/, "x"
            "#{c['utctimestamp']}, [#{obfuscated_repo_name}], #{obfuscated_msg}"
          end.join

    # replace file content with msg and commit with msg
    client = Octokit::Client.new :access_token => ENV['ACCESS_TOKEN']
    sha = client.contents(REPO, :path => LOG_FILE)[:sha]
    client.update_contents(REPO, LOG_FILE, msg, sha, msg)
  end
end
