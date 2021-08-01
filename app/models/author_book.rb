class AuthorBook < ApplicationRecord
  belongs_to :book, dependent: :destroy
  belongs_to :author, dependent: :destroy
end
