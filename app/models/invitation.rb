# frozen_string_literal: true

class Invitation < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :token, presence: true, uniqueness: true
end
