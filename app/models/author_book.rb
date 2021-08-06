class AuthorBook < ApplicationRecord
  belongs_to :book, optional: true, dependent: :destroy
  belongs_to :author, optional: true, dependent: :destroy
end
