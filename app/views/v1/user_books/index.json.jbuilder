json.key_format! camelize: :lower

json.user_books do
  json.array! @user_books do |user_book|
    json.partial! 'v1/user_books/user_book', user_book: user_book
  end
end
