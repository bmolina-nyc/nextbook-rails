class Demo::Create
  def call
    user = Demo::CreateUser.new().call
    Demo::CreateUserBooks.new(user).call
    user
  end
end
