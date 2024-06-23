# frozen_string_literal: true

module Notificationable
  extend ActiveSupport::Concern

  def create_notification!
    case self.class.name
    when 'Like'
      temp = Notification.where(['visitor_id = ? and visited_id = ? and tweet_id = ? and action_type = ? ', user_id,
                                 tweet.user.id, tweet.id, 'like'])
    when 'Tweet'
      temp_ids = Tweet.select(:user_id).where(comment_id:).where.not(user_id:).distinct
      temp_ids.each do |temp_id|
        save_notification_comment!(User.find(user_id), comment_id, temp_id['user_id'])
      end
      save_notification_comment!(User.find(user_id), comment_id, user_id) if temp_ids.blank?
      return
    when 'Retweet'
      temp = Notification.where(['visitor_id = ? and visited_id = ? and tweet_id = ? and action_type = ? ', user_id,
                                 tweet.user_id, tweet_id, 'retweet'])
    end

    return if temp.present?

    if instance_of?(::Like)
      notification = User.find(user_id).active_notifications.new(
        tweet_id: tweet.id,
        visited_id: tweet.user.id,
        action_type: 'like'
      )
    elsif instance_of?(::Retweet)
      notification = User.find(user_id).active_notifications.new(
        tweet_id: tweet.id,
        visited_id: tweet.user.id,
        action_type: 'retweet'
      )
    end

    notification.checked = true if notification.visitor_id == notification.visited_id
    notification.save if notification.valid?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(
      tweet_id: id,
      comment_id:,
      visited_id:,
      action_type: 'comment'
    )
    notification.checked = true if notification.visitor_id == notification.visited_id
    notification.save if notification.valid?
  end
end
