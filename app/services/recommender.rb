class Recommender
  def call
    titles_and_authors = taste_dive_book_recommendations(titles)
    google_books_recommendations(titles_and_authors)
  end

  private

  def google_books_recommendations(titles_and_authors)
    titles_and_authors.map do |book|
      google_books_recommendation(book[:name], book[:author])
    end
  end

  def taste_dive_book_recommendations(title)
    TasteDiveApi::Books.new(titles)
  end

  def google_books_recommendation(title, author)
    GoogleBooksApi::Recommendation.new(title, author).call
  end

end
