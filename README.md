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
{
  "data": [
    {
      "tracks": [
        {
          "type": "audio",
          "max_channels": 2,
          "max_channel_layout": "stereo",
          "id": "Zhab3kaKDKBaClnVugrMpgEveBwzwqPm",
          "duration": 442.066
        },
        {
          "type": "video",
          "max_width": 1920,
          "max_height": 1080,
          "max_frame_rate": 30,
          "id": "zlj23ndkan9alOFKnRSUDRMdqO5lhSsEw",
          "duration": 442.066667
        }
      ],
      "status": "ready",
      "playback_ids": [
        ...
      ],
      "max_stored_resolution": "HD",
      "max_stored_frame_rate": 30,
      "id": "m4921kfUQ0032814ynnzldkkaann3l901",
      "duration": 442.1,
      "created_at": "1534696086",
      "aspect_ratio": "16:9"
    }
  ]
}
```

### Creating a New Asset

```ruby
client.post_asset(url_to_video)
```

This will create the asset and return the initial data for it. The asset will
still be processing, but you can save the `id` in this response.

```json
{
  "data": {
    "status": "preparing",
    "id": "...",
    "created_at": "1534782074"
  }
}
```

You can also specify a playback policy at the same time:

```ruby
client.post_asset(url_to_video, playback_policy: 'signed')
```

Or use Per-title Encoding:

```ruby
client.post_asset(url_to_video, per_title_encode: true)
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/subdigital/mux-ruby.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
