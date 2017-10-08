class GoogleBooksApi::ResponseBuilder::Base
  def initialize(user, hash)
    @user = user
    @hash = hash
  end

  def call
    book = hash
    book = add_status_to_book(book)
    camelize_keys(book)
  end

  private

  def camelize_keys(book)
    book.transform_keys { |key| key.to_s.camelize(:lower) }
  end

  def add_status_to_book(book)
    if user.books.exists?(book[:id])
      user_book = user.user_books.find_by(google_id: book[:id])
      book.merge(
        status: user_book.status,
        user_book_id: user_book.id,
        updated_at: user_book.updated_at
      )
    else
      book.merge(
        status: nil,
        user_book_id: nil,
        updated_at: nil
      )
    end
  end

  attr_reader :user, :hash
end
