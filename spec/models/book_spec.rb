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
# Indexes
#
#  index_books_on_google_books_api_id  (google_books_api_id) UNIQUE
#
require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'バリデーション' do
    it 'タイトルは必須であること' do
      book = build(:book, title: nil)
      book.valid?
      expect(book.errors[:title]).to include('を入力してください')
    end

    it '本のIDは必須であること' do
      book = build(:book, google_books_api_id: nil)
      book.valid?
      expect(book.errors[:google_books_api_id]).to include('を入力してください')
    end

    it '本のIDは一意であること' do
      book = create(:book)
      same_id_book = build(:book, google_books_api_id: book.google_books_api_id)
      same_id_book.valid?
      expect(same_id_book.errors[:google_books_api_id]).to include('はすでに存在します')
    end
  end
end
