class ProductsController < ApplicationController

  before_action :set_product, only: %i[show edit] # En los métodos/acciones indicados, ejecutamos "set_product" en primer lugar. Nos ahorramos indicarlo explícitamente dentro de cada uno de los métodos/acciones del controlador si simplemente queremos que retorne el contenido del método precargado ("set_product").
  
  def index
    @products = Product.all.with_attached_photo
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to products_path, notice: t('.created')
    else
      render :new, status: :unprocessable_entity
    end
  end 

  def edit
  end

  def update
    if set_product.update(product_params)
      redirect_to product_path(@product), notice: t('.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    set_product.destroy

    redirect_to products_path, notice: t('.destroyed'), status: :see_other 
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
 
  def product_params
    params.require(:product).permit(:title, :description, :price, :photo)
  end

end
  