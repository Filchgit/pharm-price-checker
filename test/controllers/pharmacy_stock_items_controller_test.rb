require "test_helper"

class PharmacyStockItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pharmacy_stock_items_index_url
    assert_response :success
  end

  test "should get skip-routes" do
    get pharmacy_stock_items_skip-routes_url
    assert_response :success
  end
end
