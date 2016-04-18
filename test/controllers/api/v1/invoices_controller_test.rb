require 'test_helper'

class API::V1::InvoicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @invoice = invoices(:one)
  end

  test "should get index" do
    get api_v1_invoices_url
    assert_response :success
  end

  test "should create invoice" do
    assert_difference('Invoice.count') do
      post api_v1_invoices_url, params: { invoice: {  } }
    end

    assert_response 201
  end

  test "should update invoice" do
    patch api_v1_invoice_url(@invoice), params: { invoice: {  } }
    assert_response 200
  end

  test "should destroy invoice" do
    assert_difference('Invoice.count', -1) do
      delete api_v1_invoice_url(@invoice)
    end

    assert_response 204
  end
end
