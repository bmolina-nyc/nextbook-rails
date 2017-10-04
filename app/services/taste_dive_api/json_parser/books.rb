class TasteDiveApi::JsonParser::Books < TasteDiveApi::JsonParser::Base
  def call
    get_books_array
  end

  private

  def get_books_array
    results.map { |book| get_book_hash(book) }
  end

  def get_book_hash(book)
    {
      name: get_name(book),
      wiki_page: wiki_page(book)
    }
  end

  def get_wikipedia_url(item)
    item['wUrl']
  end

  def wikipeda_page_from_url(url)
    url.split('/').last
  end

  def wiki_page(book)
    url = get_wikipedia_url(book)
    wikipeda_page_from_url(url)
  end
end
