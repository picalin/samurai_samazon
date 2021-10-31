class UsersController < ApplicationController
  before_action :set_user

  def edit
  end

  def update
    @user.update_without_password(user_params) #update_without_passwordメソッドは、gemのdeviseをインストールしたことで使えるようになったメソッド
    redirect_to mypage_users_url
  end

  def mypage
  end

  def edit_address
  end

  private
    def set_user
      @user = current_user
    end

    def user_params
      params.permit(:name, :address, :email, :phone, :password, :password_confirmation)
    end
end
