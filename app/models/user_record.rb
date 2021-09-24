# frozen_string_literal: true

# == Schema Information
#
# Table name: user_records
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  record_id  :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_user_records_on_record_id  (record_id)
#  index_user_records_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (record_id => records.id)
#  fk_rails_...  (user_id => users.id)
#
class UserRecord < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :record, optional: true
end
