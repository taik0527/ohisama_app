# frozen_string_literal: true

# == Schema Information
#
# Table name: records
#
#  id         :bigint           not null, primary key
#  body       :text(65535)      not null
#  classroom  :string(255)      not null
#  date       :date             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Record < ApplicationRecord
  has_one_attached :image

  validates :body, presence: true
  validates :classroom, presence: true
  validates :date, presence: true

  has_many :user_records, dependent: :destroy
  has_many :users, through: :user_records
  has_many :book_records, dependent: :destroy
  has_many :books, through: :book_records

  scope :search, lambda { |keyword|
    if keyword.present?
      where('title like :q OR publisher like :q OR body like :q OR classroom like :q OR username like :q', q: "%#{keyword}%")
    end
  }
end
