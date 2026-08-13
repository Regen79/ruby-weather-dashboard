class ProfilesController < ApplicationController
  before_action :set_user
  def show
    @user
  end

  def edit
  end

  def update
    if @user.update(params.permit(:password_challenge, :password, :password_confirmation))
      @user.sessions.destroy_all
      redirect_to profile_path, notice: "Password has been changed."
    else
      render :edit, status: :unprocessable_entity
    end
  end
end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = Current.user
    end
