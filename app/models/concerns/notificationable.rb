# frozen_string_literal: true

module Notificationable
  extend ActiveSupport::Concern

  included do
    after_create :create_notification!, if: :tweet_id?
  end

  def create_notification!
    return if notification_create_invalid?

    temp = Notification.where(visitor_id: user_id, visited_id: visited_id, tweet_id: tweet_id, action_type: self.class.to_s.downcase) if defined? tweet_id

    return if temp.present?

    notification = User.find(user_id).active_notifications.new(
      tweet_id: tweet.id,
      visited_id:,
      action_type: self.class.to_s.downcase
    )

    notification.checked = true if notification.visitor_id == notification.visited_id
    notification.save if notification.valid?
  end

  def visited_id?
    raise NotImplementedError, "You must implement #{self.class}##{__method__}"
  end

  def tweet_id?
    tweet_id if defined? tweet_id
  end
end
