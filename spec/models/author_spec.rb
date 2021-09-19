require 'rails_helper'

RSpec.describe Author, type: :model do
  describe 'バリデーション' do
    it '著者名は必須であること' do
      author = build(:author, name: nil)
      author.valid?
      expect(author.errors[:name]).to include('を入力してください')
    end
  end
end
