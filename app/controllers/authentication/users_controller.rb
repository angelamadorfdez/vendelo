class Authentication::UsersController < ApplicationController
  
  skip_before_action :protect_pages

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    # User background job instead: @user.country = FetchCountryService.new(request.remote_ip).perform
    
    if @user.save
      FetchCountryJob.perform_later(@user.id, request.remote_ip) # Background job call
      session[:user_id] = @user.id
      redirect_to products_path, notice: t('.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :password)
  end

end
