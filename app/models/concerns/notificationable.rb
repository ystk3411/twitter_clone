module Notificationable
  extend ActiveSupport::Concern

  def create_notification!
    if self.class.name == "Like"
      temp = Notification.where(['visitor_id = ? and visited_id = ? and tweet_id = ? and action_type = ? ',user_id, self.tweet.user.id, self.tweet.id, 'like'])
    elsif self.class.name == "Tweet"
      temp_ids = Tweet.select(:user_id).where(comment_id: self.comment_id).where.not(user_id: user_id).distinct
      temp_ids.each do |temp_id|
        save_notification_comment!(User.find(user_id), self.comment_id, temp_id['user_id'])
      end
      save_notification_comment!(User.find(user_id), self.comment_id, user_id) if temp_ids.blank?
      return
    elsif self.class.name == "Retweet"
      temp = Notification.where(['visitor_id = ? and visited_id = ? and tweet_id = ? and action_type = ? ',user_id, self.tweet.user_id, tweet_id, 'retweet'])
    end

    return if temp.present?
    if self.class.name == "Like"
      notification = User.find(user_id).active_notifications.new(
      tweet_id: self.tweet.id,
      visited_id: self.tweet.user.id,
      action_type: 'like'
    )
    elsif self.class.name == "Retweet"
      notification = User.find(user_id).active_notifications.new(
      tweet_id: self.tweet.id,
      visited_id: self.tweet.user.id,
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