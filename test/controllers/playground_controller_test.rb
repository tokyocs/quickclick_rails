require 'test_helper'

class PlaygroundControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get playground_index_url
    assert_response :success
  end

end
