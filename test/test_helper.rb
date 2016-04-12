ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  include Warden::Test::Helpers
  Warden.test_mode!
  # def sign_in(user:, password:)
  #   post api_v1_user_session_url \
  #     "user[email]" => user.email,
  #     "user[password]" => password
  # end
end
