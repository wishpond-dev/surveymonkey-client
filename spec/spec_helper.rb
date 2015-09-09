require 'surveymonkey/client'
require 'webmock/rspec'
require 'support/fake_surveymonkey'
require 'pry'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.before(:each) do
    stub_request(:get, "https://surveymonkey.com").
      with(headers: {'Accept' => '*/*', 'User-Agent' => 'Ruby'}).
      to_return(status: 200, body: "stubbed response", headers: {})

    stub_request(:any, /https:\/\/api.surveymonkey.net\//).to_rack(FakeSurveymonkey)
  end
end
