class ProductsController < ApplicationController
  
  def index
    @products = Product.all
  end

  def show
    set_product # Sustituimos una consulta la base de datos que se repite en varias acciones por un método que usamos en su lugar
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to products_path, notice: 'Tu producto se ha creado correctamente.'
    else
      render :new, status: :unprocessable_entity
    end
  end 

  def edit
    set_product
  end

  def update
    if set_product.update(product_params)
      redirect_to product_path(@product), notice: 'Tu producto se ha actualizado correctamente.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    set_product.destroy

    redirect_to products_path, notice: 'Tu producto se ha eliminado correctamente.', status: :see_other 
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
 
  def product_params
    params.require(:product).permit(:title, :description, :price, :photo)
  end

end
  