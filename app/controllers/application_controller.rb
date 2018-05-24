class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :get_minipage_url

  include CanCan::ControllerAdditions
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to (request.referer.present? ? :back : root_url), :alert => exception.message
  end

  before_action :set_locale

  # def default_url_options
  #   { locale: I18n.locale }
  # end

  def set_locale
    logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
    I18n.locale = extract_locale_from_accept_language_header
    logger.debug "* Locale set to '#{I18n.locale}'"
  end

  private
  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end

  # Subdomain treatment
  def get_minipage_url
    if !request.subdomain.blank?
      companies = Company.where(minipage_url: request.subdomain).where.not(minipage_url: [nil, ''])
      if companies.count > 0
        @companyFromDomain = companies.first
      elsif request.subdomain != 'www'
        redirect_to root_url(subdomain: 'www')
      end
    end
  end

  # Redirect after sign in
  def after_sign_in_path_for(resource_or_scope)
    appointments_path
  end
end
