require 'test_helper'

class HelpControllerTest < ActionController::TestCase
  test "index" do
    get :index
    assert_response :success
  end

end
