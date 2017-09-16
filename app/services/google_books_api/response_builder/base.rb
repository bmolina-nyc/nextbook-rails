class GoogleBooksApi::ResponseBuilder::Base
  def initialize(user, hash)
    @hash = hash
    @user = user
  end

  private

  def camelize_keys(hash)
    hash.deep_transform_keys { |keys| keys.to_s.camelize(:lower) }
  end

  def add_status_to_book(book)
    book_record = find_book(book[:google_id])
    user_book_record = find_user_book(book_record.id) if book_record
    book_record && user_book_record ? book.merge(status: user_book_record.status)
                                    : book.merge(status: nil)
  end

  def find_book(google_id)
    Book.find_by_google_id(google_id)
  end

  def find_user_book(book_id)
    UserBook.find_by_user_and_book_id(user.id, book_id)
  end

  attr_reader :user, :hash
end
