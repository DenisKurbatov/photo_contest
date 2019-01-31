module Api
  class ApiController < ActionController::API
    before_action :merge_token_to_params

    def merge_token_to_params
      params.merge!(access_token: request.headers[:token])
    end
  end
end
