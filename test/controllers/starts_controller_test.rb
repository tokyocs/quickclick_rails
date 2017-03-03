require 'test_helper'

class StartsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @start = starts(:one)
  end

  test "should get index" do
    get starts_url
    assert_response :success
  end

  test "should get new" do
    get new_start_url
    assert_response :success
  end

  test "should create start" do
    assert_difference('Start.count') do
      post starts_url, params: { start: { problem_id: @start.problem_id, response_timing: @start.response_timing, session_id: @start.session_id, student_id: @start.student_id } }
    end

    assert_redirected_to start_url(Start.last)
  end

  test "should show start" do
    get start_url(@start)
    assert_response :success
  end

  test "should get edit" do
    get edit_start_url(@start)
    assert_response :success
  end

  test "should update start" do
    patch start_url(@start), params: { start: { problem_id: @start.problem_id, response_timing: @start.response_timing, session_id: @start.session_id, student_id: @start.student_id } }
    assert_redirected_to start_url(@start)
  end

  test "should destroy start" do
    assert_difference('Start.count', -1) do
      delete start_url(@start)
    end

    assert_redirected_to starts_url
  end
end
