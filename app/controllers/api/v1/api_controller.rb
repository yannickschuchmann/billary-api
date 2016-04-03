class API::V1::ApiController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken

  def current_user
    current_api_v1_user
  end
end
