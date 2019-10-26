class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:phone_number])
  end

  private

  def set_locale
    if !params[:locale].nil?
      I18n.locale = params[:locale]
      current_user.update_attribute(:language, I18n.locale) if user_signed_in?
    elsif user_signed_in?
      I18n.locale = current_user.language
    else
      I18n.locale = I18n.default_locale
    end
  end

  def default_url_options(options = {})
    {locale: I18n.locale}.merge options
  end
end
