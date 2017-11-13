class Demo::CreateUserBooks
  def initialize(user)
    @user = user
  end

  def call
    Demo::Data::USER_BOOKS.map do |user_book|
      user.user_books.create(user_book_params(user_book))
    end
  end

  private

  def user_book_params(user_book)
    {
      user_id: user.id,
      google_id: user_book[:google_id],
      status:  user_book[:status]
    }
  end

  attr_reader :user
end
