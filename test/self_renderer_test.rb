require "pry-test"
require "coveralls"
Coveralls.wear!
SimpleCov.command_name "pry-test"
require File.expand_path("../../lib/self_renderer", __FILE__)

class TestSelfRenderer < PryTest::Test
  test "truth" do
    assert true
  end
end
