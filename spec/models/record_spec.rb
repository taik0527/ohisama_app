# frozen_string_literal: true

# == Schema Information
#
# Table name: records
#
#  id         :bigint           not null, primary key
#  body       :text(65535)      not null
#  classroom  :string(255)      not null
#  date       :date             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
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
