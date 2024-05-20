# frozen_string_literal: true

class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :retweets, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :content, {length:{maximum:140}}
  has_one_attached :image
end
