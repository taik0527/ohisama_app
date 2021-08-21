# frozen_string_literal: true

require 'securerandom'

class InvitationsController < ApplicationController
  before_action :admin_required, only: %i[new create]

  def new
    @invitation = Invitation.new
  end

  def create
    @token = SecureRandom.base64(10)
    @invitation = Invitation.new(invitation_params.merge(token: @token, expired_at: 24.hours.since))
    if @invitation.save
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
