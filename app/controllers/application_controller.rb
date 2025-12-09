class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import
  # maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern unless Rails.env.development?

  include Authentication
  include Pagy::Method

  around_action :switch_locale

  def switch_locale(&action)
    locale = Current.user&.preferences&.language || I18n.default_locale
    I18n.with_locale(locale, &action)
  end
end
