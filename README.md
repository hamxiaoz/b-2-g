# b-2-g
It acts as a web hook. Set up web hook on Bitbucket and the activity will be transformed to Github activity

# How it works
1. Deploy this app to Heroku
2. Setup Bitbucket 'POST' hook to post to the app
3. When post receives, the app update the 'LOG' file content and commit to Github.

# How to deploy
1. Create a new Personal Access Tokens from github
2. Create a github repo to recieve those commits from Bitbucket first
3. Update the ruby file to use the above repo name: https://github.com/hamxiaoz/b-2-g/blob/master/app.rb#L17
4. Deploy to Heroku

    ```ruby
    git clone
    # change REPO name and LOG_FILE name in app.rb
    hekrou create
    heroku config:add WELCOME_MSG=xxxxxxx
    heroku config:add ACCESS_TOKEN=xxxxxxx
    ```
    
5. Setup 'POST' hook in Bitbucket to your Heroku app:
`xxxxx.herokuapp.com/commits`

