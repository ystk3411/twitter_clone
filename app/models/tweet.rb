# frozen_string_literal: true

class Tweet < ApplicationRecord
  include Notificationable
  after_create :create_notification!
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
end
