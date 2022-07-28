class ProductsController < ApplicationController
  
  def index
    @products = Product.all
  end

  def show
    #@product = Product.find_by!(id: params[:id])
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new # Genera una instancia vacia (todos los campos con nil) que rellenaremos en el formulario
  end

  def create
    @product = Product.new(product_params) # Le pasamos los parámetros que hemos indicado en el formulario.

    if @product.save
      redirect_to products_path
    else
      render :new, status: :unprocessable_entity # Devuelve código 422. Renderiza de nuevo el formulario. Necesario para devolver errores
    end
  end 

  private

  def product_params
    params.require(:product).permit(:title, :description, :price) # Requirimos la existencia de un objeto "product" y permitimos solo la escritura de los campos permitidos
  end

end
  