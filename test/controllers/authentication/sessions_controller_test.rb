require 'test_helper' # Archivo de configuración de todos los test

class Authentication::SessionsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:pepe)
  end
  
  test 'renders a new session form' do
    get new_session_path
    assert_response :success
    assert_select 'form'
  end

  test 'should login an user by email' do
    post sessions_path, params: {
        login: @user.email,
        password: 'testme' # La contraseña de las fixtures
      } 

    assert_redirected_to products_path
    assert_equal flash[:notice], 'Sesión iniciada correctamente'
  end

  test 'should login an user by username' do
    post sessions_path, params: {
        login: @user.username,
        password: 'testme' # La contraseña de las fixtures
      } 

    assert_redirected_to products_path
    assert_equal flash[:notice], 'Sesión iniciada correctamente'
  end


end
