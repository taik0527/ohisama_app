# frozen_string_literal: true

# == Schema Information
#
# Table name: invitations
#
#  id         :bigint           not null, primary key
#  email      :string(255)      not null
#  expired_at :datetime         not null
#  token      :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_invitations_on_email  (email) UNIQUE
#  index_invitations_on_token  (token) UNIQUE
#
require 'rails_helper'

RSpec.describe Invitation, type: :model do
  describe 'バリデーション' do
    it 'メールアドレスは必須であること' do
      invitation = build(:invitation, email: nil)
      invitation.valid?
      expect(invitation.errors[:email]).to include('を入力してください')
    end

    it 'メールアドレスは一意であること' do
      invitation = create(:invitation)
      same_email_invitation = build(:invitation, email: invitation.email)
      same_email_invitation.valid?
      expect(same_email_invitation.errors[:email]).to include('はすでに存在します')
    end

    it 'トークンは必須であること' do
      invitation = build(:invitation, token: nil)
      invitation.valid?
      expect(invitation.errors[:token]).to include('を入力してください')
    end

    it 'トークンは一意であること' do
      invitation = create(:invitation)
      same_token_invitation = build(:invitation, token: invitation.token)
      same_token_invitation.valid?
      expect(same_token_invitation.errors[:token]).to include('はすでに存在します')
    end
    it '制限時間は必須であること' do
      invitation = build(:invitation, expired_at: nil)
      invitation.valid?
      expect(invitation.errors[:expired_at]).to include('を入力してください')
    end
  end
end
