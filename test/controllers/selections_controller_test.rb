require 'test_helper'

class SelectionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @selection = selections(:one)
  end

  test "should get index" do
    get selections_url
    assert_response :success
  end

  test "should get new" do
    get new_selection_url
    assert_response :success
  end

  test "should create selection" do
    assert_difference('Selection.count') do
      post selections_url, params: { selection: { answer: @selection.answer, problem_id: @selection.problem_id, response_timing: @selection.response_timing, session_id: @selection.session_id, student_id: @selection.student_id } }
    end

    assert_redirected_to selection_url(Selection.last)
  end

  test "should show selection" do
    get selection_url(@selection)
    assert_response :success
  end

  test "should get edit" do
    get edit_selection_url(@selection)
    assert_response :success
  end

  test "should update selection" do
    patch selection_url(@selection), params: { selection: { answer: @selection.answer, problem_id: @selection.problem_id, response_timing: @selection.response_timing, session_id: @selection.session_id, student_id: @selection.student_id } }
    assert_redirected_to selection_url(@selection)
  end

  test "should destroy selection" do
    assert_difference('Selection.count', -1) do
      delete selection_url(@selection)
    end

    assert_redirected_to selections_url
  end
end
