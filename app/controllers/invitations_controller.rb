# frozen_string_literal: true

class InvitationsController < Decidim::ApplicationController
  include Decidim::UserProfile

  helper 'decidim/admin/icon_link'

  before_action :check_remaining_invites, only: %i(new create)
  before_action :check_invitation_update, only: %i(resend destroy)


  def index
    @users = current_organization.users.
      where(invited_by: current_user).page(params[:page]).per(20).
      order(created_at: :asc)
  end

  def new
    @form = form(FundAction::InviteUserForm).instance
    @form.num_invites = 0 # default to 0 invites
  end

  def create
    @form = form(FundAction::InviteUserForm).from_params params

    FundAction::InviteUsers.(@form, current_user) do
      on(:ok) do |successes|
        flash[:notice] = I18n.t("invitations.sent", count: successes.size)
        redirect_to user_invitations_path
      end

      on(:invalid) do |successes, errors|
        if successes.any?
          flash.now[:alert] = I18n.t("invitations.some_errors", errors: errors.size, count: successes.size)
        else
          flash.now[:alert] = I18n.t("invitations.error", count: errors.size)
        end
        render :new
      end
    end

  end


  # resend invitation
  def resend
    Decidim::InviteUserAgain.(@invited_user, "invited_by_user") do
      on(:ok) do
        flash[:notice] = I18n.t("users.resend_invitation.success", scope: "decidim.admin")
      end

      on(:invalid) do
        flash[:alert] = I18n.t("users.resend_invitation.error", scope: "decidim.admin")
      end
    end

    redirect_to user_invitations_path
  end


  # revoke invitation
  def destroy
    FundAction::RemoveInvitation.(@invited_user) do
      on(:ok) do
        flash[:notice] = I18n.t("destroy.success", scope: "invitations")
      end

      on(:invalid) do
        flash[:alert] = I18n.t("destroy.error", scope: "invitations")
      end
    end

    redirect_to user_invitations_path
  end


  private

  def check_remaining_invites
    unless current_user.has_invitations_left?
      redirect_to user_invitations_path
      return false
    end
  end

  def check_invitation_update
    @invited_user = current_organization.users.find params[:id]

    if @invited_user&.invited_to_sign_up? and
      @invited_user.invited_by == current_user and
      !@invited_user.invitation_accepted?

      true
    else
      redirect_to user_invitations_path
      false
    end
  end

end
