require 'rack'
require 'erroneous-api/client'
require 'erroneous-api/server'
require 'erroneous-api/fake'

describe "Erroneous API basic use case" do

  it "sends an error log and gets a response" do

    ERRONEOUS_HOST = 'http://errornous.hax/'

    app = Rack::Builder.app do
      if ENV["DEBUG"]
        require 'request_visualizer'
        use RequestVisualizer
      end
      map ERRONEOUS_HOST do
        ErroneousAPI::Server.mapper = ErroneousAPI::Fake
        run ErroneousAPI::Server
      end
    end

    @client = ErroneousAPI::Client.new(ERRONEOUS_HOST)
    ErroneousAPI::Client.mock!(app)

    text = "Deploy initiated.\nRunning command BLAH.\nDoing This.\nERROR! ERROR! HORRIBLE TERRIBLE THINGS!\n" +
           "[Relax] Your site is still running old code and nothing destructive has occurred."

    failed_deploy = @client.parse_deploy_fail(text)
    failed_deploy.lines.should eq [4]
    failed_deploy.summary.should eq "you had ERROR."
    failed_deploy.details.should eq "retry by doing this thing that takes multiple sentences to descibe. bla. bla."
  end

end