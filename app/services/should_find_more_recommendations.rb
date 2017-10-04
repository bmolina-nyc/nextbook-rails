class ShouldFindMoreRecommendations
  def initialize(user)
    @user = user
    @liked = user.liked
    @last_request_date = user.recommendations.last.created_at
  end

  def call
    any_liked? &&
      last_request_made_over_20_minutes_ago? &&
        number_of_books_liked_since_last_request >= 2
  end

  private

  def any_liked?
     liked.length > 0
  end

  def last_request_made_over_20_minutes_ago?
    last_request_date < 20.minutes.ago
  end

  def number_of_books_liked_since_last_request
    liked.where("books.created_at > ?", last_request_date).length
  end

  attr_reader :user, :liked, :last_request_date
end
