# frozen_string_literal: true

class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :retweets
  has_many :comments
end
