# frozen_string_literal: true

module Notificationable
  extend ActiveSupport::Concern

  included do
    after_create :create_notification!
  end

  def create_notification!
    visited_id? unless self.class.method_defined?(:visited_id)

    return if is_notification_create_invalid?

    temp = Notification.where(['visitor_id = ? and visited_id = ? and tweet_id = ? and action_type = ? ', user_id,
                               tweet.user_id, tweet_id, self.class.to_s.downcase])

    return if temp.present?

    notification = User.find(user_id).active_notifications.new(
      tweet_id: tweet.id,
      visited_id:,
      action_type: self.class.to_s.downcase
    )

    notification.checked = true if notification.visitor_id == notification.visited_id
    notification.save if ånotification.valid?
  end

  def visited_id?
    raise NotImplementedError, "You must implement #{self.class}##{__method__}"
  end
end
