## Erroneous-API

An API Client for the Engine Yard Deploy-Log-Parsing-Service, code name: "Erroneous".

## Usage

```ruby
  client = ErroneousAPI::Client.new("http://erroneous.engineyard.com/api")
  failed_deploy = client.parse_deploy_fail("full text of deploy log")
  puts failed_deploy.lines
  puts failed_deploy.details
  puts failed_deploy.summary
```

## Add this API into your app

```ruby
Implement the mapper:

ErroneousAPI::Server.mapper = MyMapper

module MyMapper
  def self.parse_deploy_fail(message)
    if message.match(/bundle failed/i)
      {
        # we use these fields to display human readable on the dashboard for customers
        :summary => 'bundle failed!',
        :details => 'Deploy failed because of bundler. Please rebundle the app.',
        # we use this to anchor to the right part in the log.
        :lines => [2..5].to_a,
      }
    end
  end
end

```
