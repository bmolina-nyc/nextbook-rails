json.key_format! camelize: :lower

unless @user_books
  []
end

json.array! @user_books do |user_book|
  json.partial! 'v1/user_books/user_book', user_book: user_book
end
