class UserRecord < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :record, optional: true
end
