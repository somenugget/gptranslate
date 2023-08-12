class UpdateLanguageUsageWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find_by(id: user_id)

    return unless user

    user.language_usages = CalculateLanguageUsage.call(user: user).output
    user.save!
  end
end
