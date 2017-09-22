class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!, if: :login_required?

  private

  def login_required?
    unless %w(
      decidim/cookie_policy
      decidim/errors
    ).include? params[:controller]

      return true
    end
  end
end
