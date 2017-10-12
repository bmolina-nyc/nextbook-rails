class AddRecommenderInfoToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :last_request_date, :datetime,
               default: 5.minutes.ago
    add_column :users, :recommender_job, :integer
  end
end
