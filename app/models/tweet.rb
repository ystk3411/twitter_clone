# frozen_string_literal: true

class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :retweets, dependent: :destroy
  has_many :comments, class_name: 'Tweet', foreign_key: 'comment_id', dependent: :destroy, inverse_of: :tweet
  belongs_to :tweet, class_name: 'Tweet', foreign_key: 'comment_id', optional: true, inverse_of: :comments
  has_many :read_counts, dependent: :destroy
  has_many :book_marks, dependent: :destroy
  validates :content, { length: { maximum: 140 } }
  has_one_attached :image
  has_many :notifications, dependent: :destroy

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  def retweeted_by?(user)
    retweets.where(user_id: user.id).exists?
  end

  def bookmarked_by?(user)
    book_marks.where(user_id: user.id).exists?
  end

  def create_notification_like!(current_user)
     temp = Notification.where(['visitor_id = ? and visited_id = ? and tweet_id = ? and action_type = ? ', current_user.id,user_id, id, 'like'])

    return if temp.present?

      notification = current_user.active_notifications.new(
      tweet_id: id,
      visited_id: user_id,
      action_type: 'like'
      )

      notification.checked = true if notification.visitor_id == notification.visited_id
      notification.save if notification.valid?
  end

  def create_notification_comment!(current_user, tweet_id)
    temp_ids = Tweet.select(:user_id).where(comment_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(
      tweet_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action_type: 'comment'
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    p notification.valid?
    notification.save if notification.valid?
  end
end
