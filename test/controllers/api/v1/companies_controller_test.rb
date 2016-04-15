require 'test_helper'

class API::V1::CompaniesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @company = companies(:one)
  end


  # test "should update company" do
  #   patch api_v1_company_url(@company), params: { company: {  } }
  #   assert_response 200
  # end

end
