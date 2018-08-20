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

  def list_assets
    get('/video/v1/assets')
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

  def connection(path)
    Excon.new(MUX_BASE_URL + path,
      user: access_token_id,
      password: secret_key,
      debug_requests: debug_enabled,
      debug_responses: debug_enabled)
  end
end
