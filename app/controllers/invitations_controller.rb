require 'securerandom'

class InvitationsController < ApplicationController

  def new
    @invitation = Invitation.new
  end

  def create
    # トークンにランダムな文字列を入れる
    @token = SecureRandom.base64(10)
    @invitation = Invitation.new(invitation_params.merge(token: @token))
    if @invitation.save
      # メールの送信
      UserMailer.invitation(@invitation).deliver_now
      redirect_to users_path, success: 'ユーザーを招待しました'
    else
      flash.now[:danger] = '招待メールの送信に失敗しました'
      render :new
    end

  end

  private

  def invitation_params
    params.require(:invitation).permit(:email)
  end
end
