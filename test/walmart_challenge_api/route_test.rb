require './test/test_helper'

class RouteTest < MiniTest::Test
  def test_it_exists
    Route.create(:origin_point => 'A', :destination_point => 'D', :distance => 20)
    assert_equal 1, Route.count
  end
end