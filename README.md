# NeoDash

## Setup

```ruby
bundle install
bundle exec dashing start
```

visit http://localhost:3030/ci to view your pretty dashbord.

![screen shot 2013-11-19 at 5 21 45 pm](https://f.cloud.github.com/assets/412533/1571300/37fcee5a-5101-11e3-8b54-17f285d2e124.png)

## Widgets

- Jenkins build status
- World clock
- Google calendar

To configure any of the widgets:
- Edit `config/config.json`
- Restart the server by running `bundle exec dashing stop` then `bundle exec dashing start`

## Notes

Instead of the [original shopyfy dashing](http://shopify.github.io/dashing/), this project uses [a custom Dashing version by @tomazy](https://github.com/tomazy/dashing/tree/dashboard-from-config) (see Gemfile)

Jenkins build status widget is based on @tomazy's [jenkins-build-status](https://github.com/tomazy/jenkins-status-dashing)

Google calendar widget is based on @akalyaev's [Yet another Google Calendar Dashing widget](https://gist.github.com/akalyaev/6387762)

To push from Kent-Ridge.local, first `ssh-add -D` to clear all SSH identities. Run `ssh-add ~/.ssh/id_github_neodash` to add the Neodash deployment key. (Refer to this [gist](https://gist.github.com/jexchan/2351996) for more details)

If you've updated it remotely, on the office network, ssh into Kent-Ridge by running `ssh neo@kent-ridge.local`, go to the repo and pull, then restart the server.
