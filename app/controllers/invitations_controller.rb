# frozen_string_literal: true

require 'securerandom'

class InvitationsController < ApplicationController
  before_action :admin_required, only: %i[new create]

  def new
    @invitation = Invitation.new
  end

  def create
    if User.exists?(invitation_params)
      flash.now[:danger] = 'ユーザー作成済みのメールアドレスです'
      @invitation = Invitation.new
      render :new
    else
      @token = SecureRandom.hex(10)
      @invitation = Invitation.new(invitation_params.merge(token: @token, expired_at: 24.hours.since))
      if @invitation.save
        UserMailer.invitation(@invitation).deliver_now
        redirect_to users_path, notice: 'ユーザーを招待しました'
      else
        flash.now[:danger] = '招待メールが送信できません'
        render :new
      end
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:email)
  end
end
