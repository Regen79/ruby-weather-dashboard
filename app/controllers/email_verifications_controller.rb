class EmailVerificationsController < ApplicationController
  allow_unauthenticated_access
  before_action :set_user_by_token

  def show
    @user.update(verified: true)
    redirect_to new_session_path, notice: "Email verified successfully! You can now log in."
  end

  private

    def set_user_by_token
      @user = User.find_by_token_for(:email_verification, params[:token])
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      redirect_to new_session_path, alert: "The verification link is invalid or has expired."
    end
end
