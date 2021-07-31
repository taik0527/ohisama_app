class Record < ApplicationRecord
  has_one_attached :images

  validates :body, presence: true
  validates :classroom, presence: true
  
  has_many :user_records
  has_many :users, through: :user_records
  has_many :book_records
  has_many :books, through: :book_records
end
