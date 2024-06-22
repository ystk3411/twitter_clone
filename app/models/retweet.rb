# frozen_string_literal: true

class Retweet < ApplicationRecord
  include Notificationable
  after_create :create_notification!
  belongs_to :user
  belongs_to :tweet
end
