class Book < ApplicationRecord
  self.primary_key = :google_id

  has_many :user_books, foreign_key: :google_id
  has_many :users, through: :user_books

  def self.latest_titles
    self.last(6).pluck :title
  end

  def self.published_date(date_string)
    date_split = date_string.split('-').map(&:to_i)
    Date.new(*date_split)
  end
end
