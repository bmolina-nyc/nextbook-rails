class GoogleBooksApi::ResponseBuilder::Search
  def initialize(user, hash)
    @user = user
    @hash = hash
  end

  def call
    search = hash
    search[:items] = build_responses(search[:items])
    camelize_keys(search)
  end

  private

  def camelize_keys(hash)
    hash.transform_keys { |key| key.to_s.camelize(:lower) }
  end

  def build_responses(books)
    books.map { |book| build_response(book) }
  end

  def build_response(book)
    GoogleBooksApi::ResponseBuilder::Base.new(user, book).call
  end

  attr_reader :user, :hash
end
