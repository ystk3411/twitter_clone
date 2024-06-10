# frozen_string_literal: true

class BookMark < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :tweet, class_name: 'Tweet'
end
