class TasteDiveApi::ResponseBuilder
  def initialize(user, titles_array)
    @user = user
    @titles_array = titles_array
  end

  def call
    remove_books_marked_by_user
  end

  private

  def remove_books_marked_by_user
    titles_array.reject { |title| marked_by_user?(title) }
  end

  def marked_by_user?(title)
    user.books.find_by_title(title)
  end

  attr_reader :user, :titles_array
end
