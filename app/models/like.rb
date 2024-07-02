# frozen_string_literal: true

class Like < ApplicationRecord
  include Notificationable
  belongs_to :user, class_name: 'User'
  belongs_to :tweet, class_name: 'Tweet'

  def notification_create_invalid?
    User.find(user_id).id == visited_id
  end

  def visited_id
    tweet.present? ? tweet.user.id : 0
  end
end
