require 'test_helper'

class InboundControllerTest < ActionController::TestCase
  test "should get start_receiving" do
    get :start_receiving
    assert_response :success
  end

  test "should get confirm_lp" do
    get :confirm_lp
    assert_response :success
  end

end
