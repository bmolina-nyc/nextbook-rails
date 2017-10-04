class Book < ApplicationRecord
  self.primary_key = :google_id

  has_many :user_books, foreign_key: :google_id
  has_many :users, through: :user_books

  def self.latest_titles
    self.last(6).pluck :title
  end
end
