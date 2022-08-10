require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:maria)
  end

  test "should get index" do
    get user_path(@user.username)
    assert_response :success
  end

  test 'render a list of products' do
    get user_path(@user.username)

    assert_select '.category', 0
    assert_select '.product', 4
  end

end
