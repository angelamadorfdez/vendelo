require 'test_helper' # Archivo de configuración de todos los test

class Authentication::UsersControllerTest < ActionDispatch::IntegrationTest
  
  test 'renders a new user form' do
    get new_user_path

    assert_response :success
    assert_select 'form'
  end

  test 'allow to create a new user' do
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
