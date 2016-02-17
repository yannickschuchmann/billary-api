require 'test_helper'

class TimeEntryTest < ActiveSupport::TestCase
  test "stopped is greater than started" do
    assert time_entries(:one).started_at <= time_entries(:one).stopped_at
  end

  test "duration" do
    assert_equal time_entries(:one).duration, 10
  end

  test "is running" do
    assert time_entries(:running).running?
  end
end
