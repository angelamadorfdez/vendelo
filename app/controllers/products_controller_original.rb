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
      redirect_to products_path, notice: 'Tu producto se ha creado correctamente.'
    else
      render :new, status: :unprocessable_entity # Devuelve código 422. Renderiza de nuevo el formulario. Necesario para devolver errores
    end
  end 

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      redirect_to product_path(@product), notice: 'Tu producto se ha actualizado correctamente.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    redirect_to products_path, notice: 'Tu producto se ha eliminado correctamente.', status: :see_other # Status 303 (para que Turbo no se lie al cambiar el método PHP de GET a DELETE)
 
  end

  private
 
  def product_params
    params.require(:product).permit(:title, :description, :price, :photo) # Requirimos la existencia de un objeto "product" y permitimos solo la escritura de los campos permitidos
  end

end
  