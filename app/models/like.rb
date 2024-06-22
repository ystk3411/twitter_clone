# frozen_string_literal: true

class Like < ApplicationRecord
  include Notificationable
  after_create :create_notification!
  belongs_to :user, class_name: 'User'
  belongs_to :tweet, class_name: 'Tweet'
end
