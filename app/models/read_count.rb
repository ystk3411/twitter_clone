# frozen_string_literal: true

class ReadCount < ApplicationRecord
  belongs_to :user
  belongs_to :tweet
end
