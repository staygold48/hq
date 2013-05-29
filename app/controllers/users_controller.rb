class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]

  def index
    @users = User.all
  end

  def edit ; end

  def update
    if @user.update(user_params) && @user.update_name(user_name_params)
      redirect_to users_path, notice: 'Изменения сохранены.'
    else
      render action: :edit
    end
  end

  private

  def set_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:username, :email, :phone)
  end

  def user_name_params
    params.require(:user).permit(:last_name_ip, :first_name_ip, :patronym_ip,
                                 :last_name_rp, :first_name_rp, :patronym_rp,
                                 :last_name_dp, :first_name_dp, :patronym_dp,
                                 :last_name_vp, :first_name_vp, :patronym_vp,
                                 :last_name_tp, :first_name_tp, :patronym_tp,
                                 :last_name_pp, :first_name_pp, :patronym_pp)
  end
end