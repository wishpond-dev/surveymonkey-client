require 'sinatra/base'

class FakeSurveymonkey < Sinatra::Base

  post '/v2/user/get_user_details' do
    if check_token(params['api_key'])
      json_response(200, 'user.json')
    else
      json_response(400, 'error.json')
    end
  end

  post '/v2/surveys/get_survey_list' do
    if check_token(params['api_key'])
      json_response(200, 'surveys.json')
    else
      json_response(400, 'error.json')
    end
  end

  post '/v2/surveys/get_respondent_list' do
    if check_token(params['api_key'])
      json_response(200, 'respondents.json')
    else
      json_response(400,'error.json')
    end
  end

  private

  def json_response(response_code, file_name)
    content_type :json
    status response_code
    File.open(File.dirname(__FILE__) + '/fixtures/' + file_name, 'rb').read
  end

  def check_token(token)
    token == '12345abcde'
  end
end
