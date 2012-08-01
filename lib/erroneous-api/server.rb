require 'sinatra/base'

module ErroneousAPI
  class Server < Sinatra::Base
    enable :raise_errors
    disable :dump_errors
    disable :show_exceptions

    class << self
      attr_accessor :mapper
    end

    def self.mock!
      require 'erroneous-api/fake'
      require 'erroneous-api/client'
      self.mapper = ErroneousAPI::Fake
      ErroneousAPI::Client.mock!(self)
    end

    post '/parse_deploy_fail' do
      begin
        deploy_log = JSON.parse(request.body.read)["deploy_log"]
        content_type :json
        result = ErroneousAPI::Server.mapper.parse_deploy_fail(deploy_log)
        {
          :lines => (result[:lines] or raise "Expected parse_deploy_fail to return which :lines (empty array allowed)").to_a,
          :details => (result[:details] or raise "Expected parse_deploy_fail to return the :details (empty string allowed)"),
          :summary => (result[:summary] or raise "Expected parse_deploy_fail to return the :summary (empty string allowed)")
        }.to_json
      rescue JSON::ParserError
        status 400
      end
    end
  end
end