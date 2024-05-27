# frozen_string_literal: true

class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :retweets, dependent: :destroy
  has_many :comments, class_name: 'Tweet', foreign_key: 'comment_id', dependent: :destroy
  has_many :read_counts, dependent: :destroy
  validates :content, { length: { maximum: 140 } }
  has_one_attached :image

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end
