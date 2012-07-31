require 'sinatra/base'

module ErroneousAPI
  class Server < Sinatra::Base
    enable :raise_errors
    disable :dump_errors
    disable :show_exceptions

    class << self
      attr_accessor :mapper
    end

    post '/parse_deploy_fail' do
      deploy_log = JSON.parse(request.body.read)["deploy_log"]
      content_type :json
      result = Server.mapper.parse_deploy_fail(deploy_log)
      {
        :lines => (result[:lines] or raise "Expected parse_deploy_fail to return which :lines (empty array allowed)").to_a,
        :details => (result[:details] or raise "Expected parse_deploy_fail to return the :details (empty string allowed)"),
        :summary => (result[:summary] or raise "Expected parse_deploy_fail to return the :summary (empty string allowed)")
      }.to_json
    end
  end
end