# frozen_string_literal: true

class Record < ApplicationRecord
  has_many_attached :images

  validates :body, presence: true
  validates :classroom, presence: true
  validates :date, presence: true

  has_many :user_records, dependent: :destroy
  has_many :users, through: :user_records
  has_many :book_records, dependent: :destroy
  has_many :books, through: :book_records
end
