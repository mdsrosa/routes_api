require './test/test_helper'

class RouteTest < ActiveSupport::TestCase
  test 'origin_point must be present' do
    route = Route.create(origin_point: nil)
    assert route.errors[:origin_point].any?
  end

  test 'destination_point must be present' do
    route = Route.create(destination_point: nil)
    assert route.errors[:destination_point].any?
  end

  test 'distance must be present' do
    route = Route.create(distance: nil)
    assert route.errors[:distance].any?
  end
end