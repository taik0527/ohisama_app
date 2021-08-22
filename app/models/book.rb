# frozen_string_literal: true

class Book < ApplicationRecord
  has_one_attached :image

  validates :title, presence: true
  validates :google_books_api_id, presence: true, uniqueness: true

  has_many :book_records, dependent: :destroy
  has_many :records, through: :book_records
  has_many :author_books, dependent: :destroy
  has_many :authors, through: :author_books

  scope :search, lambda { |keyword|
    where('title like :q OR publisher like :q OR name like :q', q: "%#{keyword}%") if keyword.present?
  }
  scope :storage, -> { where(storage: true) }
end
