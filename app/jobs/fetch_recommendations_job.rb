class FetchRecommendationsJob < ApplicationJob
  queue_as :default

  def perform(user)
    Recommender.new(user).call
  end

  after_enqueue do |job|
    user = job.arguments.first
    user.update recommender_job: job.job_id
  end

  after_perform do |job|
    user = job.arguments.first
    user.reset_recommender_info
  end
end
