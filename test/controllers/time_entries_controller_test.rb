require 'test_helper'

class TimeEntriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @time_entry = time_entries(:one)
  end

  test "should get index" do
    get time_entries_url
    assert_response :success
  end

  test "should create time_entry" do
    assert_difference('TimeEntry.count') do
      post time_entries_url, params: { time_entry: { manual: @time_entry.manual, project_id: @time_entry.project_id, started_at: @time_entry.started_at, stopped_at: @time_entry.stopped_at } }
    end

    assert_response 201
  end

  test "should show time_entry" do
    get time_entry_url(@time_entry)
    assert_response :success
  end

  test "should update time_entry" do
    patch time_entry_url(@time_entry), params: { time_entry: { manual: @time_entry.manual, project_id: @time_entry.project_id, started_at: @time_entry.started_at, stopped_at: @time_entry.stopped_at } }
    assert_response 200
  end

  test "should destroy time_entry" do
    assert_difference('TimeEntry.count', -1) do
      delete time_entry_url(@time_entry)
    end

    assert_response 204
  end
end
