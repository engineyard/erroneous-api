$:.unshift File.dirname(__FILE__) + '/lib'
require 'erroneous-api/version'

#gem server: public
Gem::Specification.new do |s|
  s.name = 'erroneous-api'
  s.authors = ["Jacob Burkhart", "Shai Rosenfeld"]
  s.email = ["cloud-engineering@engineyard.com"]
  s.version = ErroneousAPI::VERSION
  s.summary = "An API Client for the Engine Yard Deploy-Log-Parsing-Service, code name: \"Erroneous\"."
  s.description = "An API Client for the Engine Yard Deploy-Log-Parsing-Service: Erroneous"
  s.files = Dir['lib/**/*']

  s.add_dependency 'json'
  s.add_dependency 'ey_api_hmac'

  ## Server Dependencies
  # gemspec is not a sufficient format to specify them, and we don't want to be bothered to build a separate gem
  #s.add_dependency 'sinatra',      '~>1.0'
end
