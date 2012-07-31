require 'ey_api_hmac'
require 'uri'
module ErroneousAPI
  class Client

    def initialize(base_url)
      @base_url = base_url
    end

    def mock!(backend)
      self.connection.backend = backend
    end

    def connection
      @connection ||= EY::ApiHMAC::BaseConnection.new
    end

    def parse_deploy_fail(text)
      connection.post(URI.join(@base_url, '/parse_deploy_fail').to_s, {:deploy_log => text}) do |json_response, location_header|
        Response.new(json_response)
      end
    end

    class Response
      attr_accessor :lines, :summary, :details
      def initialize(json_response)
        @lines = json_response['lines']
        @summary = json_response['summary']
        @details = json_response['details']
      end
    end
  end
end