require 'application_system_test_case'

class StockItemsTest < ApplicationSystemTestCase
  test 'visiting the index' do
    login_as users(:johntest)
    visit root_url
    assert_selector 'h1', text: 'Current Tracked Items'
  end
end
