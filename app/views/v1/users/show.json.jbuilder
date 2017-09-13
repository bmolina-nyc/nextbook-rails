json.key_format! camelize: :lower

json.user do
  json.partial! 'v1/users/user', user: @user
end
