class UserMailer < ApplicationMailer
  def invitation(invitation)
    @invitation = invitation
    mail(
      subject: 'おひさまアプリ招待メール',
      to: @invitation.email
    )
  end

  def user_created(user)
    @user = user
    mail(
      subject: 'おひさまアプリユーザー登録完了メール',
      to: @user.email
    )
  end
end
