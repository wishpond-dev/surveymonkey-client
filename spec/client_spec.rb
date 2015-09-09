require 'spec_helper'

describe Surveymonkey::Client do
  subject { Surveymonkey::Client.new }
  let(:token) { '12345abcde' }
  let(:api_key) { '12345abcde'}
  let(:bad_api_key) { '12345abcd'}
  let(:username) { 'wishpond' }
  let(:client) { Surveymonkey::Client.new(api_key, token)}
  let(:bad_client) { Surveymonkey::Client.new(bad_api_key, token)}

  describe '#initialize' do
    it 'stores the api_key' do
      expect(client.api_key).to eq(api_key)
      expect(client).to be_an_instance_of(Surveymonkey::Client)
    end
  end

  describe '#user' do
    it 'returns the users info' do
      response = client.user['data']['user_details']['username']
      expect(response).to eq(username)
    end
  end

  describe '#get_survey_list' do
    it 'returns the collection of surveys' do
      response = client.surveys
      expect(response['data']['page_size']).to eq(1000)
      expect(response['data']['surveys'].size).to eq(3)
    end

    context 'wrong api_key' do
      it 'returns an error message' do
       response = bad_client.surveys
        expect(response['error']).to eq('Unknown api key')
      end
    end
  end

  describe '#get_respondent_list' do
    it 'returns the collection of respondents' do
      survey = client.surveys['data']['surveys'].first
      response = client.respondents(survey['survey_id'])
      expect(response['data']['page_size']).to eq(1000)
      expect(response['data']['respondents'].size).to eq(5)
    end

    context 'wrong api_key' do
      it 'returns an error message' do
        survey = client.surveys['data']['surveys'].first
        response = bad_client.respondents(survey['survey_id'])
        expect(response['error']).to eq('Unknown api key')
      end
    end
  end

end
