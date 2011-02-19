require 'test_helper'

class InventoryManagementControllerTest < ActionController::TestCase
  test "should get containers" do
    get :containers
    assert_response :success
  end

  test "should get inventory_updates" do
    get :inventory_updates
    assert_response :success
  end

  test "should get locations" do
    get :locations
    assert_response :success
  end

  test "should get shipments" do
    get :shipments
    assert_response :success
  end

  test "should get assignments" do
    get :assignments
    assert_response :success
  end

end
