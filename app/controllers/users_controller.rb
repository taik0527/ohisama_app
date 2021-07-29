class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]

  def index
    @users = User.all
  end

  def new
    # クエリパラメータのtokenがinvitation内のレコードにあるか判定
    if @invitation = Invitation.find_by(token: params[:token])
      @user = User.new
    else
      # クエリパラメータの文字列が間違ったURLなので、適切なエラー画面を表示したい
    end
  end

  def create
    if @invitation = Invitation.find_by(token_params)
      @user = User.new(user_params.merge(email: @invitation.email))
      if @user.save
        # 使用したレコードを消去
        @invitation.destroy
        # ログイン状態にする
        session[:user_id] = @user.id
        # 登録完了メールの送信
        UserMailer.user_created(@user).deliver_now
        # 画面遷移
        redirect_to root_path, success: 'サインアップが完了しました'
      else
        redirect_to request.referer, notice: "サインアップに失敗しました"
      end
    else
      redirect_to request.referer, notice: "サインアップに失敗しました"
    end
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_update_params)
      redirect_to users_path, success: 'プロフィールを更新しました'
    else
      flash.now['danger'] = 'プロフィールの更新に失敗しました'
      render :edit
    end
  end

  def destroy
    @user = User.find(id: params[:id])
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
