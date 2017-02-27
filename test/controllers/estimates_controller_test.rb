require 'test_helper'

class EstimatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @estimate = estimates(:one)
  end

  test "should get index" do
    get estimates_url
    assert_response :success
  end

  test "should get new" do
    get new_estimate_url
    assert_response :success
  end

  test "should create estimate" do
    assert_difference('Estimate.count') do
      post estimates_url, params: { estimate: { estimated_time: @estimate.estimated_time, problem_id: @estimate.problem_id, response_timing: @estimate.response_timing, session_id: @estimate.session_id, student_id: @estimate.student_id } }
    end

    assert_redirected_to estimate_url(Estimate.last)
  end

  test "should show estimate" do
    get estimate_url(@estimate)
    assert_response :success
  end

  test "should get edit" do
    get edit_estimate_url(@estimate)
    assert_response :success
  end

  test "should update estimate" do
    patch estimate_url(@estimate), params: { estimate: { estimated_time: @estimate.estimated_time, problem_id: @estimate.problem_id, response_timing: @estimate.response_timing, session_id: @estimate.session_id, student_id: @estimate.student_id } }
    assert_redirected_to estimate_url(@estimate)
  end

  test "should destroy estimate" do
    assert_difference('Estimate.count', -1) do
      delete estimate_url(@estimate)
    end

    assert_redirected_to estimates_url
  end
end
