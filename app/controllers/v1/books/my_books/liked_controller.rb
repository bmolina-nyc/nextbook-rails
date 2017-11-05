class V1::Books::MyBooks::LikedController < V1::Books::MyBooksController

  # GET v1/books/my_books/liked
  # def index
  # end
  
  private

  def filtered_books
    @books ||= current_user.liked_books
  end
end
