## How to deploy

 * Add Heroku to your Gemfile and `bundle install`.
 * Create your Heroku app. This will only work with their (currently-beta) 'cedar' stack, so you have to `heroku create --stack=cedar`.
 * Create a `Procfile` for your bot. This tells Heroku how to run your worker. In our case, the only line in the Procfile is `cinch: bundle exec ruby init.rb`
 * Commit and push to Heroku.
 * You do not want a Web worker running, so `heroku scale web=0` and `heroku scale cinch=1`. This also sets up your deployments to restart the bot.

## How to contribute

 * Fork, code and submit an PULL REQUEST
 * You can join at `##gurupi` on `irc.freenode.org`

## License

zurg is released under the MIT license, more details see MIT-LICENSE.
