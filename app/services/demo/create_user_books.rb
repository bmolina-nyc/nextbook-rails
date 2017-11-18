class Demo::CreateUserBooks
  def initialize(user)
    @user = user
  end

  def call
    ActiveRecord::Base.connection.execute(sql_string)
  end

  private

  def sql_string
    string = 'INSERT INTO user_books '
    string += "(status, user_id, google_id, created_at, updated_at) VALUES #{values}"
  end

  def values
    values = Demo::Data::USER_BOOKS.map do |user_book|
      time = timestamp
      "(#{UserBook.statuses[user_book[:status]]}, #{user.id}, '#{user_book[:google_id]}', '#{time}', '#{time}')"
    end
    values.join(',')
  end

  def timestamp
    10.minutes.ago.strftime "%Y-%m-%d %H:%M:%S.%6N"
  end

  attr_reader :user
end
