class Recommender
  def initialize(user)
    @user = user
  end

  def call
    recommendations = retrieve_recommendations.compact
    return nil if recommendations.length == 0
    add_recommendations(recommendations)
  end

  private

  def add_recommendations(recommendations)
    recommendations.map { |rec| add_recommendation(rec) }.reject(&:blank?)
  end

  def retrieve_recommendations
    taste_dive_books(user.liked_titles).map do |book|
      gb_rec = google_books_recommendation(book[:title], book[:author])
      gb_lookup = google_books_lookup(gb_rec[:id])
      next nil unless has_all_required_fields?(gb_lookup)
      next nil if gb_lookup['status']
      gb_lookup
    end
  end

  def add_recommendation(rec)
    book = Book.find_by(google_id: rec['id'])
    create_book(rec) unless book
    user.user_books.create google_id: rec['id'], status: 'recommended'
  end

  def create_book(rec)
    Book.create(
      google_id: rec['id'],
      title: rec['title'],
      subtitle: rec['subtitle'],
      published_date_string: rec['publishedDate'],
      page_count: rec['pageCount'],
      published_date: Book.published_date(rec['publishedDate'])
    )
  end

  def has_all_required_fields?(lookup)
    lookup.slice(*required_lookup_fields).values.all? { |val| val != nil }
  end

  def taste_dive_books(titles)
    TasteDiveApi::Books.new(titles).call
  end

  def google_books_recommendation(title, author)
    GoogleBooksApi::Recommendation.new(title, author).call
  end

  def google_books_lookup(id)
    GoogleBooksApi::Lookup.new(id, user).call
  end

  def required_lookup_fields
    %w(id title thumbnail description publisheDate pageCount authors categories publisher)
  end

  attr_reader :user
end
