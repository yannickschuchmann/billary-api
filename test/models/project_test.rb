require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  test "sub has a parent" do
    assert projects(:subone).parent.present?
  end

  test "presence of name" do
    p = Project.new
    assert_not p.save
  end
end
