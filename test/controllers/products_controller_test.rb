require 'test_helper' # Archivo de configuración de todos los test

class ProductsControllerTest < ActionDispatch::IntegrationTest

  setup do
    login
  end
  
  test 'render a list of products' do
    get products_path

    assert_response :success
    assert_select '.category', 10
    assert_select '.product', 10
  end

  test 'render a list of products filtered by category' do
    get products_path(category_id: categories(:videogames).id)

    assert_response :success
    assert_select '.category', 10
    assert_select '.product', 8
  end

  test 'render a list of products filtered by min_price and max_price' do
    get products_path(min_price: 50, max_price: 1000)

    assert_response :success
    assert_select '.category', 10
    assert_select '.product', 10

    assert_select 'h2', 'PS4 Fat'
  end

  test 'render a list of products filtered by query' do
    get products_path(query_text: 'ps4')

    assert_response :success
    assert_select '.category', 10
    assert_select '.product', 1

    assert_select 'h2', 'PS4 Fat'
  end

  test 'render a list of products filtered by cheaper prices first' do
    get products_path(order_by: 'cheaper')

    assert_response :success
    assert_select '.product', 10
    assert_select '.products .product:first-child h2', 'El hobbit'
  end

  test 'render a list of products filtered by expensive prices first' do
    get products_path(order_by: 'more_expensive')

    assert_response :success
    assert_select '.product', 10
    assert_select '.products .product:first-child h2', 'Dacia Sandero'
  end
  
  test 'render a detailed product page' do 
    get product_path(products(:ps4))

    assert_response :success
    assert_select '.title', 'PS4 Fat'
    assert_select '.description', 'PS4 en buen estado'
    assert_select '.price', '120€'
  end

  test 'renders a new product form' do
    get new_product_path

    assert_response :success
    assert_select 'form'
  end

  test 'allow to create a new product' do
    post products_path, params: {
      product: {
        title: "PS4 Fat",
        description: "PS4 en buen estado",
        price: 120,
        category_id: categories(:videogames).id
        }
    } 

    assert_redirected_to products_path
    assert_equal flash[:notice], 'Producto creado correctamente'
    
  end

  test 'does not allow to create a new product with empty fields' do
    post products_path, params: {
      product: {
        title: '',
        description: 'Muy buen estado. Falta el mando.',
        price: 95
        }
    } 

    assert_response :unprocessable_entity
  end

  test 'allow to edit a product' do
    get edit_product_path(products(:ps4))

    assert_response :success
    assert_select 'form'
  end

  test 'allows to update a new product' do
    patch product_path(products(:ps4)), params: {
      product: {
        price: 165
        }
    } 

    assert_redirected_to product_path(products(:ps4))
    assert_equal flash[:notice], 'Producto actualizado correctamente'
  end

  test 'does not allow to update a new product' do
    patch product_path(products(:ps4)), params: {
      product: {
        price: nil
        }
    } 

    assert_response :unprocessable_entity
  end

  test 'can delete products' do 

    assert_difference('Product.count', -1) do
      delete product_path(products(:ps4))
    end

    assert_redirected_to products_path
    assert_equal flash[:notice], 'Producto eliminado correctamente'

  end

end
