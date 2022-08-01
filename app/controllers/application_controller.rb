class ApplicationController < ActionController::Base

  around_action :switch_locale # Por cada petición, se llama al método switch_locale

  def switch_locale(&action)
    I18n.with_locale(locale_from_header, &action) ## with_locale cambia el idioma de lo que se muestra. Se le está pasando el "locale_from_header"
  end

  private

  def locale_from_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first # el idioma que tiene el usuario en su navegador. Se obtiene leyendo la cabecera que se está enviando en la petición.
  end

end
