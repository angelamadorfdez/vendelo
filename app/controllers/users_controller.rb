class UsersController < ApplicationController

  skip_before_action :protect_pages, only: :show

  def show
    @user = User.find_by!(username: params[:username])

    # @products = FindProducts.new.call(user_id: @user.id).load_async
    # @pagy, @products = pagy_countless(@products, items: 10)
    
    # @products = @user.products
    # @pagy, @products = pagy_countless(@products, items: 10)

    @pagy, @products = pagy_countless(@user.products, items: 10)
    
  end

end
