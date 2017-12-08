class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :fund_action_authenticate_user!, if: :login_required?

  private

  # the aliasing prevents i.e. proposals_controller to change the condition
  alias fund_action_authenticate_user! authenticate_user!

  def login_required?
    unless %w(
      decidim/cookie_policy
      decidim/errors
    ).include? params[:controller]

      return true
    end
  end
end
