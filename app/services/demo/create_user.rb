class Demo::CreateUser
  def call
    User.create(user_params)
  end

  private

  def user_params
    password = SecureRandom.hex(6)
    {
      email: generate_email,
      password: password,
      password_confirmation: password,
      last_request_date: 5.minutes.ago
      # demo_account: true
    }
  end

  def generate_email
    "demo-#{SecureRandom.hex(12)}@example.com"
  end
end
