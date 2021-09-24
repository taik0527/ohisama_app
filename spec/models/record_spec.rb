# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Record, type: :model do
  describe 'バリデーション' do
    it '備考は必須であること' do
      record = build(:record, body: nil)
      record.valid?
      expect(record.errors[:body]).to include('を入力してください')
    end

    it '学級は必須であること' do
      record = build(:record, classroom: nil)
      record.valid?
      expect(record.errors[:classroom]).to include('を入力してください')
    end

    it '日にちは必須であること' do
      record = build(:record, date: nil)
      record.valid?
      expect(record.errors[:date]).to include('を入力してください')
    end
  end
end
