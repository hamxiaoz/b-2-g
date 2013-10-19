# b-2-g
Bitbucket activity transform to Github activity

# How it works
1. Deploy this app to Heroku
2. Setup Bitbucket 'POST' hook to post to the app
3. When post receives, the app update the 'LOG' file content and commit to Github.

# How to deploy
1. Create a new Personal Access Tokens from github
2. Deploy to Heroku

    ```ruby
    git clone
    # change REPO name and LOG_FILE name in app.rb
    hekrou create
    heroku config:add WELCOME_MSG=xxxxxxx
    heroku config:add ACCESS_TOKEN=xxxxxxx
    ```
    
3. Setup 'POST' hook in Bitbucket to your Heroku app:
`xxxxx.herokuapp.com/commits`

