class GoogleBooksApi::ResponseBuilder::Search < GoogleBooksApi::ResponseBuilder::Base
  def initialize(user, hash)
    super(user, hash)
  end

  def call
    books = hash
    books[:items] = add_status_to_books(books[:items])
    camelize_keys(books)
  end

  private

  def add_status_to_books(books)
    books.map { |book| add_status_to_book(book) }
  end
end
