require 'test_helper' # Archivo de configuración de todos los test

class Authentication::UsersControllerTest < ActionDispatch::IntegrationTest
  
  test 'renders a new user form' do
    get new_user_path

    assert_response :success
    assert_select 'form'
  end

  test 'allow to create a new user' do
    stub_request(:get, "http://ip-api.com/json/127.0.0.1").
      to_return(status: 200, body: {
        status: "fail",
        }.to_json, headers: {})
    assert_difference("User.count") do
      post users_path, params: {
        user: {
          email: "fulanito@vendelo.com",
          username: "fulanito27",
          password: "testme",
          }
      } 
    end

    assert_redirected_to products_path
    assert_equal flash[:notice], 'Tu cuenta se ha creado correctamente'
  end

end
