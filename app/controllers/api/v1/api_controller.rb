class API::V1::ApiController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken

  def current_user
    if Rails.env.test?
      User.create(email: "#{rand(50000)}@example.com",
                  password: "password",
                  confirmed_at: Time.now)
    else
      current_api_v1_user
    end
  end
end
