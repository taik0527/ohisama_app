# frozen_string_literal: true

class BookRecord < ApplicationRecord
  belongs_to :book, optional: true
  belongs_to :record, optional: true
end
