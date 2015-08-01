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

  test 'origin_point and destination_point must be unique' do
    route1 = Route.create(origin_point: 'A', destination_point: 'D', distance: 10)
    route2 = Route.create(origin_point: 'A', destination_point: 'D', distance: 10)
    assert route2.errors.messages.any?
  end
end