require 'spec_helper'

describe 'External request' do
  it 'tries to hit the surveymonkey api' do
    uri = 'https://surveymonkey.com'

    response = HTTParty.get(uri)

    expect(response.body).to eq("stubbed response")
  end

end
