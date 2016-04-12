require 'test_helper'
include Devise::TestHelpers

class API::V1::ClientsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client = clients(:one)
  end

  test "should get index" do
    get api_v1_clients_url
    assert_response :success
  end

  test "should create client" do
    assert_difference('Client.count') do
      post api_v1_clients_url, params: { client: {  } }
    end

    assert_response 201
  end

  test "should show client" do
    get api_v1_client_url(@client)
    assert_response :success
  end

  test "should update client" do
    patch api_v1_client_url(@client), params: { client: {  } }
    assert_response 200
  end

  test "should destroy client" do
    assert_difference('Client.count', -1) do
      delete api_v1_client_url(@client)
    end

    assert_response 204
  end
end
