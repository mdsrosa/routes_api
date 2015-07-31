require './test/test_helper'

class WalmartChallengeApiTest < MiniTest::Unit::TestCase
  def test_it_works
    assert_equal 42, WalmartChallengeApi.answer
  end
end