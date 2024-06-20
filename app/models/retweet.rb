# frozen_string_literal: true

class Retweet < ApplicationRecord
  belongs_to :user
  belongs_to :tweet

  def create_notification_retweet!(current_user)
    temp_1 = Notification.where(['visitor_id = ? and visited_id = ? and tweet_id = ? and action_type = ? ', current_user.id,user_id, tweet_id, 'retweet'])
    p temp_1.present?
    return if temp_1.present?

    notification = current_user.active_notifications.new(
      tweet_id: tweet_id,
      visited_id: user_id,
      action_type: 'retweet'
    )
    notification.checked = true if notification.visitor_id == notification.visited_id
    notification.save if notification.valid?
  end
end
