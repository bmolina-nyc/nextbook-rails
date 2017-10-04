class UserBook < ApplicationRecord
  enum status: {
    liked: 0,
    disliked: 1,
    want_to_read: 2,
    already_read: 3,
    recommended: 4,
    rejected: 5
  }

  USER_MARKED_KEYS = statuses.keys - [:recommended]

  belongs_to :user
  belongs_to :book, foreign_key: :google_id
end
