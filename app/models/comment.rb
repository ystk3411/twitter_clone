# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :tweet
  has_one_attached :image
  has_many :comment
  has_many :read_counts
end
