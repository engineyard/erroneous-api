require 'spec_helper'

describe "Erroneous API basic use case" do

  it "sends an error log and gets a response" do

    ERRONEOUS_HOST = 'http://errornous.hax/'

    app = Rack::Builder.app do
      if ENV["DEBUG"]
        require 'request_visualizer'
        use RequestVisualizer
      end
      map ERRONEOUS_HOST do
        run Erroneous::Server::Fake
      end
    end

    @client = Erroneous::Client.new(ERRONEOUS_HOST)
    @client.mock!(app)
    @client
  end

end