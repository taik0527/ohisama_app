# frozen_string_literal: true

# == Schema Information
#
# Table name: authors
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Author < ApplicationRecord
  validates :name, presence: true

  has_many :author_books
  has_many :books, through: :author_books
end
