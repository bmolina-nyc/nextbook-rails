class Recommender

  def initialize(user)
    @user = user
  end

  def call
    titles_and_authors = taste_dive_book_recommendations(user.liked_titles)
    recommendations = google_books_recommendations(titles_and_authors)
    add_recommendations(recommendations)
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
      create_book(
        rec[:id],
        rec[:title],
        rec[:subtitle],
        rec[:published_date],
        rec[:page_count]
      )
      create_recommendation(rec[:id])
    elsif !user.books.exists?(rec[:id])
      create_recommendation(rec[:id])
    end
  end

  def create_book(google_id, title, subtitle, published_date, page_count)
    puts "google_id: #{google_id}, title: #{title}, subtitle: #{subtitle}, published_date: #{published_date}, page_count: #{page_count}"
    Book.create(
      google_id: google_id,
      title: title,
      subtitle: subtitle,
      published_date_string: published_date,
      page_count: page_count,
      published_date: published_date(published_date)
    )
  end

  def published_date(date_string)
    date_split = date_string.split('-').map(&:to_i)
    Date.new(*date_split)
  end

  def create_recommendation(google_id)
    user.user_books.create google_id: google_id, status: 'recommended'
  end

  def google_books_recommendations(titles_and_authors)
    titles_and_authors.map do |book|
      google_books_recommendation(book[:name], book[:author])
    end
  end

  def taste_dive_book_recommendations(titles)
    TasteDiveApi::Books.new(titles).call
  end

  def google_books_recommendation(title, author)
    GoogleBooksApi::Recommendation.new(title, author).call
  end

  attr_reader :user
end
