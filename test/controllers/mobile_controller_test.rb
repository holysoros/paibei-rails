require 'test_helper'

class MobileControllerTest < ActionController::TestCase
  test "should get nfc_show" do
    get :nfc_show
    assert_response :success
  end

  test "should get qrcode_verify" do
    get :qrcode_verify
    assert_response :success
  end

  test "should get qrcode_verify_result" do
    get :qrcode_verify_result
    assert_response :success
  end

  test "should get contact_us" do
    get :contact_us
    assert_response :success
  end

end
