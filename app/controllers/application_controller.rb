class ApplicationController < ActionController::Base
  protect_from_forgery

  include TheRole::Controller

    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    protect_from_forgery
    before_action :set_locale

    private

    def set_locale
      locale = 'en'
      langs  = %w{ en ru es pl zh_CN }

      if params[:locale]
        lang = params[:locale]
        if langs.include? lang
          locale           = lang
          cookies[:locale] = lang
        end
      else
        if cookies[:locale]
          lang   = cookies[:locale]
          locale = lang if langs.include? lang
        end
      end

      I18n.locale = locale
      redirect_back(fallback_location: root_path) if params[:locale]
    end
end
