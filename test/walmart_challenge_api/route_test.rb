require './test/test_helper'

class RouteTest < MiniTest::Unit::TestCase
  include WithRollback

  def test_it_exists
    assert_equal 0, Route.count
    temporarily do
      route = Route.create(:origin_point => 'A', :destination_point => 'D', :distance => 20)
      assert_equal 1, Route.count
    end
    assert_equal 0, Route.count
  end
end