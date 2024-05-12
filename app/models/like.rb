# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :tweet, class_name: 'Tweet'
end
