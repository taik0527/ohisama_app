class UsersController < ApplicationController
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
        redirect_to root_path, success: 'ユーザーを作成しました'
      else
        redirect_to request.referer, notice: "ユーザーを作成出来ません"
      end
    else
      redirect_to request.referer, notice: "ユーザーを作成出来ません"
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:password, :username)
  end

  def token_params
    params.require(:user).permit(:token)
  end
end
