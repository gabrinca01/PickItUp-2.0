require "test_helper"

class ProfilepageControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get profilepage_index_url
    assert_response :success
  end
end
