class User < ApplicationRecord
  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_books
  has_many :books, through: :user_books

  with_options through: :user_books, source: :book do |assoc|
    assoc.has_many :liked_books,        -> { UserBook.liked }
    assoc.has_many :disliked_books,     -> { UserBook.disliked }
    assoc.has_many :want_to_read_books, -> { UserBook.want_to_read }
    assoc.has_many :already_read_books, -> { UserBook.already_read }
    assoc.has_many :recommendations,    -> { UserBook.recommended }
    assoc.has_many :rejected_books,     -> { UserBook.rejected }
    assoc.has_many :marked_books,       -> { UserBook.user_marked }
  end

  def liked_titles
    self.books_liked_since_last_request.pluck :title
  end

  def books_liked_since_last_request
    self.liked_books.where(
      "user_books.updated_at > ?",
      self.last_request_date
    )
  end

  def can_fetch_recommendations?
    self.last_request_date ?
     self.last_request_date < 5.minutes.ago : false
  end

  def reset_recommender_info
    self.update last_request_date: DateTime.now, recommender_job: nil
  end
end
