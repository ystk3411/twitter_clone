class Notification < ApplicationRecord
  belongs_to :tweet, optional: true
  belongs_to :comment, class_name: 'Tweet', foreign_key: 'comment_id', optional: true
  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id'
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id'
end
