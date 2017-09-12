class UserBook < ApplicationRecord
  enum status: {
    to_be_read: 0,
    liked: 1,
    disliked: 2,
    recommended: 3
  }

  belongs_to :user
end
