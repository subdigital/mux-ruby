# Mux

A ruby client for the mux.com api.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mux-ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mux-ruby

## Usage

Create a mux client:

```ruby
client = Mux.new(
  access_token_id: your_access_token,
  secret_key: your_secret_key
)
```

Or you can provide the environment variables `MUX_ACCESS_TOKEN_ID` and `MUX_ACCESS_TOKEN_SECRET_KEY`,
and initialize the client with no arguments:

```ruby
ENV['MUX_ACCESS_TOKEN_ID'] = your_access_token
ENV['MUX_ACCESS_TOKEN_SECRET_KEY'] = your_secret_key

client = Mux.new
```

### Listing Assets

To list assets:

```ruby
client.list_assets
```

```json

```


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/mux-ruby.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
