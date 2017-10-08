json.books do
  json.array! @books do |book|
    json.partial! 'v1/books/book', book: book
  end
end
