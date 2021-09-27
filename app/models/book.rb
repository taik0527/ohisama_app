# frozen_string_literal: true

# == Schema Information
#
# Table name: books
#
#  id                  :bigint           not null, primary key
#  publisher           :string(255)      not null
#  storage             :boolean          default(FALSE), not null
#  title               :string(255)      not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  google_books_api_id :string(255)      not null
#
class Book < ApplicationRecord
  has_one_attached :image

  validates :title, presence: true
  validates :google_books_api_id, presence: true, uniqueness: true

  has_many :book_records, dependent: :destroy
  has_many :records, through: :book_records
  has_many :author_books, dependent: :destroy
  has_many :authors, through: :author_books

  scope :search, ->(keyword) {
    where('title like :q OR publisher like :q OR name like :q', q: "%#{keyword}%") if keyword.present?
  }
  scope :storage, -> { where(storage: true) }
end
