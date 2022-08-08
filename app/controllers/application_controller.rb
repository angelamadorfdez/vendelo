class ApplicationController < ActionController::Base

  include Pagy::Backend

  class NotAuthorizedError < StandardError; end
  rescue_from NotAuthorizedError do
    redirect_to products_path, alert: t('common.not_authorized')
  end

  around_action :switch_locale # Por cada petición, se llama al método switch_locale
  before_action :set_current_user
  before_action :protect_pages

  def switch_locale(&action)
    I18n.with_locale(locale_from_header, &action) ## with_locale cambia el idioma de lo que se muestra. Se le está pasando el "locale_from_header"
  end

  private

  def locale_from_header
    request.env['HTTP_ACCEPT_LANGUAGE']&.scan(/^[a-z]{2}/)&.first # el idioma que tiene el usuario en su navegador. Se obtiene leyendo la cabecera que se está enviando en la petición.
  end

  def set_current_user
    # @current_user = User.find_by(id: session[:user_id]) # OPCION 1
    Current.user = User.find_by(id: session[:user_id]) if session[:user_id] # OPCION 2 usando Rails Current
  end

  def protect_pages
    redirect_to new_session_path, alert: t('common.not_logged_in') unless Current.user
  end

  def authorize! product
    is_allowed = product.user_id == Current.user.id
    # redirect_to products_path, alert: t('common.not_authorized') unless is_allowed
    raise NotAuthorizedError unless is_allowed
  end

end
 