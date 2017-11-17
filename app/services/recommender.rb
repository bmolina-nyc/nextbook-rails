class Recommender

  def initialize(user)
    @user = user
  end

  def call
    titles_and_authors = taste_dive_book_recommendations(user.liked_titles)
    recommendations = google_books_recommendations(titles_and_authors)
    filtered = filter_recommendations(recommendations)
    add_recommendations(filtered) if filtered
  end

  private

  def add_recommendations(recommendations)
    recommendations
    .map { |rec| add_recommendation(rec) }
    .reject(&:blank?)
  end

  def add_recommendation(rec)
    book = Book.find_by(google_id: rec[:id])
    if !book
      Book.create(
        google_id: rec[:id],
        title: rec[:title],
        subtitle: rec[:subtitle],
        published_date_string: rec[:published_date],
        page_count: rec[:page_count],
        published_date: Book.published_date(rec[:published_date])
      )
    end
    create_recommendation(rec[:id])
  end

  def create_recommendation(google_id)
    user.user_books.create google_id: google_id, status: 'recommended'
  end

  def google_books_recommendations(titles_and_authors)
    titles_and_authors.map do |book|
      google_books_recommendation(book[:name], book[:author])
    end
  end

  def filter_recommendations(recommendations)
    recommendations.map do |rec|
      lookup = google_books_lookup(rec[:id])
      return nil unless lookup.slice(required_fields).values.all? { |val| val != nil }
      return nil if user.user_books.exists?(google_id: rec[:id])
      rec
    end.compact
  end

  def taste_dive_book_recommendations(titles)
    TasteDiveApi::Books.new(titles).call
  end

  def google_books_recommendation(title, author)
    GoogleBooksApi::Recommendation.new(title, author).call
  end

  def google_books_lookup(id)
    GoogleBooksApi::Lookup.new(id, user).call
  end

  def required_fields
    %w(
      title thumbnail description publisheDate
      pageCount authors categories publisher
    )
  end

  attr_reader :user
end
