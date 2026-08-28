class ProfilesController < ApplicationController
  before_action :set_user
  def show
    @user
  end

  def edit
  end

  def update
    if @user.update(user_params)
      @user.sessions.where.not(id: Current.session.id).destroy_all
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

    def user_params
      params.expect(user: [ :password_challenge, :password, :password_confirmation ])
    end
