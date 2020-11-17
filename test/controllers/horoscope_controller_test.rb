require 'test_helper'

class HoroscopeControllerTest < ActionDispatch::IntegrationTest
  test "should get test" do
    get horoscope_test_url
    assert_response :success
  end

end
