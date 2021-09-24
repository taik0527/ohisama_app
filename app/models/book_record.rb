# frozen_string_literal: true

# == Schema Information
#
# Table name: book_records
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  book_id    :bigint
#  record_id  :bigint
#
# Indexes
#
#  index_book_records_on_book_id    (book_id)
#  index_book_records_on_record_id  (record_id)
#
# Foreign Keys
#
#  fk_rails_...  (book_id => books.id)
#  fk_rails_...  (record_id => records.id)
#
class BookRecord < ApplicationRecord
  belongs_to :book, optional: true
  belongs_to :record, optional: true
end
