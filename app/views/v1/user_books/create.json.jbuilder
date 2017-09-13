json.key_format! camelize: :lower

json.user_book do
  json.partial! 'v1/user_books/user_book', user_book: @user_book
end
