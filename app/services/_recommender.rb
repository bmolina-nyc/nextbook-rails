class Recommender
  def initialize(titles, user, limit = LIMIT_DEFAULT)
    @titles = titles
    @user = user
    @limit = limit
    @recommendations = []
  end

  def call
    titles.each do |title|
      parsed = Rails.cache.fetch("rec-#{title}", expires_in: 30.days) do
        fetch_and_parse_google_books(title)
      end
      book = build_response(parsed)
      unless marked_by_user?(book['id'])
        recommendations << book
        add_recommendation(book)
      end
      break if recommendations.length == limit
    end
    recommendations
  end

  private

  LIMIT_DEFAULT = 20

  def add_recommendation(book)
    book_record = nil
    begin
      book_record = Book.find(book['id'])
    rescue ActiveRecord::RecordNotFound
      book_record = Book.create(
        google_id: book['id'],
        title: book['title'],
        subtitle: book['subtitle']
      )
    ensure
      UserBook.create(
        user_id: user.id,
        book_id: book_record.id,
        status: :recommended
      )
    end
  end

  def fetch_and_parse_google_books(title)
    url = klass('UrlGenerator').new(title).call
    response = Requester.new(url).call
    klass('JsonParser').new(response).call
  end

  def build_response(hash)
    GoogleBooksApi::ResponseBuilder::Base.new(user, hash).call
  end

  def marked_by_user?(google_id)
    user.books.exists? google_id: google_id
  end

  def klass(module_name)
    "GoogleBooksApi::#{module_name}::Recommendation".constantize
  end

  attr_reader :titles, :user, :limit
  attr_accessor :recommendations
end
