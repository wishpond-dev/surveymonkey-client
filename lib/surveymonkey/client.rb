require "surveymonkey/client/version"

module Surveymonkey
  module Client
    class Client
      attr_reader :api_key, :access_token

      API_URL = "https://api.surveymonkey.net/v2/"

      def initialize(api_key, access_token)
        @api_key = api_key
        @access_token = access_token
      end

      def user(options = "")
        body = {}.to_json
        get_request("user/get_user_details", options, body)
      end

      def surveys(options = "")
        body = {:fields => ["title"]}.to_json
        get_request("surveys/get_survey_list", options, body)
      end

      def respondents(survey_id, options = "")
        body = {:survey_id => survey_id, :fields => ["email", "first_name", "last_name"]}.to_json
        get_request("surveys/get_respondent_list", options, body)
      end

      private

      def uri_generator(endpoint, options = "")
        "#{API_URL}#{endpoint}?api_key=#{@api_key}"
      end

      def get_request(endpoint, options = "", body)
        response = HTTParty.post(uri_generator(endpoint, options),
          :headers => { "Authorization" => "bearer #{@access_token}", "Content-Type" => "application/json" },
          :body => body
          )
        end
   end
end
