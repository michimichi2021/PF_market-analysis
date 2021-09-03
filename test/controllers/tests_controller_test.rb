require 'test_helper'

class TestsControllerTest < ActionDispatch::IntegrationTest
  test "should get test" do
    get tests_test_url
    assert_response :success
  end

end
