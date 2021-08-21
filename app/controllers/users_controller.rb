# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :login_required, only: %i[new create]

  def index
    @users = User.all.page(params[:page]).per(10)
  end

  def new
    if @invitation = Invitation.find_by(token: params[:token])
      if @invitation.expired_at > Time.now
        @user = User.new
      else
        render  'error/error_404'
      end
    else
      render  'error/error_404'
    end
  end

  def create
    if @invitation = Invitation.find_by(token_params)
      @user = User.new(user_params.merge(email: @invitation.email))
      if @user.save
        @invitation.destroy
        session[:user_id] = @user.id
        UserMailer.user_created(@user).deliver_now
        redirect_to root_path, success: 'サインアップが完了しました'
      else
        redirect_to request.referer, notice: 'サインアップに失敗しました'
      end
    else
      redirect_to request.referer, notice: 'サインアップに失敗しました'
    end
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_update_params)
      redirect_to users_path, notice: 'プロフィールを更新しました'
    else
      flash.now['danger'] = 'プロフィールの更新に失敗しました'
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: "ユーザー「#{@user.username}」を削除しました。"
  end

  private

  def user_params
    params.require(:user).permit(:password, :username)
  end

  def user_update_params
    params.require(:user).permit(:username)
  end

  def token_params
    params.require(:user).permit(:token)
  end
end
