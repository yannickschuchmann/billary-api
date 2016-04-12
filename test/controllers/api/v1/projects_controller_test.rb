require 'test_helper'
include Devise::TestHelpers

class API::V1::ProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = projects(:one)
  end

  test "should get index" do
    get api_v1_projects_url
    assert_response :success
  end

  test "should create project" do
    assert_difference('Project.count') do
      post api_v1_projects_url, params: { project: { name: @project.name, parent_id: @project.parent_id } }
    end

    assert_response 201
  end

  test "should show project" do
    get api_v1_project_url(@project)
    assert_response :success
  end

  test "should update project" do
    patch api_v1_project_url(@project), params: { project: { name: @project.name, parent_id: @project.parent_id } }
    assert_response 200
  end

  test "should destroy project" do
    assert_difference('Project.count', (@project.count_all_children + 1) * -1 ) do
      delete api_v1_project_url(@project)
    end

    assert_response 204
  end
end
