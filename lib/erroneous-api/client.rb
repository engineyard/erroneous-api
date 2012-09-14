require 'ey_api_hmac'
require 'uri'
module ErroneousAPI
  class Client

    def initialize(base_url)
      @base_url = base_url
    end

    class << self
      attr_accessor :mock_backend
    end

    def self.mock!(backend)
      @mock_backend = backend
    end

    def connection
      @connection ||= setup_connection
    end

    def parse_deploy_fail(text, deployment_id)
      connection.post(URI.join(@base_url, '/parse_deploy_fail').to_s, {:deployment_log => text, :deployment_id => deployment_id}) do |json_response, location_header|
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

    private

    def setup_connection
      connection = EY::ApiHMAC::BaseConnection.new
      if Client.mock_backend
        connection.backend = Client.mock_backend
      end
      connection
    end

  end
end