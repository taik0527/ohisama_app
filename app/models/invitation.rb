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
class Invitation < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :token, presence: true, uniqueness: true
  validates :expired_at, presence: true
end
