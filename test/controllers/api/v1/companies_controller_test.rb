require 'test_helper'

class API::V1::CompaniesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @company = companies(:one)
  end

  test "should get index" do
    get companies_url
    assert_response :success
  end

  test "should create company" do
    assert_difference('Company.count') do
      post companies_url, params: { company: {  } }
    end

    assert_response 201
  end

  test "should show company" do
    get company_url(@company)
    assert_response :success
  end

  test "should update company" do
    patch company_url(@company), params: { company: {  } }
    assert_response 200
  end

  test "should destroy company" do
    assert_difference('Company.count', -1) do
      delete company_url(@company)
    end

    assert_response 204
  end
end
