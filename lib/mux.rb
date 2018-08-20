require 'mux/version'
require 'mux/errors'
require 'excon'
require 'json'

class Mux
  MUX_BASE_URL = 'https://api.mux.com'
  attr_reader :access_token_id
  attr_reader :secret_key

  attr_accessor :debug_enabled

  def initialize(access_token_id = ENV.fetch('MUX_ACCESS_TOKEN_ID'), secret_key = ENV.fetch('MUX_ACCESS_TOKEN_SECRET_KEY'))
    @access_token_id = access_token_id
    @secret_key = secret_key

    self.debug_enabled = true
  end

  # List mux assets. Returns a JSON response for each asset,
  # including metadata, and playback ids.
  def list_assets
    get('/video/v1/assets')
  end

  # Posts a new asset. Response will include the asset id
  # and any playback ids initially created.
  # Params:
  #   url             -  A publicly accessible URL to the asset for mux to fetch.
  #   playback_policy -  Create a playback policy with the provided value. Valid
  #                      values are 'signed', and 'public'. If omitted, no
  #                      playback ids will be created.
  #   per_title_encode - Allows the server to provide optimal encoding for this
  #                      asset, but requires additional time to process. `true`
  #                      or `false`.
  def post_asset(url, params = {})
    post '/video/v1/assets', {
      input: url
    }.merge(params)
  end

  # Returns a mux asset, including status.
  def asset(asset_id)
    get "/video/v1/assets/##{asset_id}"
  end
  private

  def get(path, params = {})
    response = connection(path).get(query: params)
    if response.status == 200
      JSON.parse(response.body)
    else
      raise Mux::Error.new(response.status, response.body)
    end
  end

  def post(path, params)
    response = connection(path).post(
      body: params.to_json,
      headers: {
        'Content-Type': 'application/json'
      })
    if [200, 201].include?(response.status)
      JSON.parse(response.body)
    else
      raise Mux::Error.new(response.status, response.body)
    end
  end

  def connection(path)
    Excon.new(MUX_BASE_URL + path,
      user: access_token_id,
      password: secret_key,
      debug_request: debug_enabled,
      debug_response: debug_enabled)
  end
end
