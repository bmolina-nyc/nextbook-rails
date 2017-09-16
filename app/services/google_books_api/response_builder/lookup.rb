class GoogleBooksApi::ResponseBuilder::Lookup < GoogleBooksApi::ResponseBuilder::Base
  def initialize(user, hash)
    super(user, hash)
  end

  def call
    book = hash
    book = add_status_to_book(book)
    camelize_keys(book)
  end
end
