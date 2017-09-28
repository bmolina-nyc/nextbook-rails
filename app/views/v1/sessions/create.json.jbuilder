json.key_format! camelize: :lower

json.user do
  json.call(
    @user,
    :email,
    :authentication_token
  )
end
