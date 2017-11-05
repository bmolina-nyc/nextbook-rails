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
    user_book = user.user_books.find_by(google_id: book[:id])
    book.merge({
      status: user_book&.status,
      book: book
    })
  end

  attr_reader :user, :hash
end
