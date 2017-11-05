class V1::Books::MyBooks::DislikedController < V1::Books::MyBooksController

  # GET v1/books/my_books/disliked
  # def index
  # end
  
  private

  def filtered_books
    @books ||= current_user.disliked_books
  end
end
