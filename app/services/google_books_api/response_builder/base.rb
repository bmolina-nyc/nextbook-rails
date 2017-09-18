class GoogleBooksApi::ResponseBuilder::Base
  def initialize(user, hash)
    @user = user
    @hash = hash
  end

  private

  def camelize_keys(hash)
    hash.deep_transform_keys { |keys| keys.to_s.camelize(:lower) }
  end

  def add_status_to_book(book)
    user_book = user.user_books.find(book[:id])
  rescue ActiveRecord::RecordNotFound
    book.merge(status: nil)
  else
    book.merge(status: user_book.status)
  end

  attr_reader :user, :hash
end
