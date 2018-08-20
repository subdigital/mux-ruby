class Mux
  class Error < StandardError
    def initialize(status, body)
      @status = status
      @body = body
      super "HTTP #{status} -> #{body}"
    end
  end
end
