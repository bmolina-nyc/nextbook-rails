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
    assoc.has_many :recommended_books,  -> { UserBook.recommended }
    assoc.has_many :rejected_books,     -> { UserBook.rejected }
    assoc.has_many :marked_books,       -> { UserBook.user_marked }
  end

  def book_ids(limit)
    self.marked_books.last(limit).pluck :google_id
  end
end
