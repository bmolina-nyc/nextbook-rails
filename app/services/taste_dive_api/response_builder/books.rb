class TasteDiveApi::ResponseBuilder::Books
  def initialize(books)
    @books = books
  end

  def call
    add_authors(books)
  end

  private

  def add_authors(hash)
    hash
      .map    { |book| add_author(book) }
      .reject { |book| book[:author].empty? }
  end

  def add_author(book)
    book.merge(author: get_author_for_wiki(book[:wiki_page]))
  end

  def get_author_for_wiki(wiki_page)
    WikipediaApi::GetAuthor.new(wiki_page).call
  end

  attr_reader :books
end
