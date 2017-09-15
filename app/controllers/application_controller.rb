class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!, if: :login_required?

  private

  def login_required?
    unless (
      params[:controller] == 'decidim/pages' and
      params[:action] == 'show' and
      params[:id] == 'terms-and-conditions'
    ) or (
      params[:controller] == 'decidim/cookie_policy'
    )

      return true
    end
  end
end
