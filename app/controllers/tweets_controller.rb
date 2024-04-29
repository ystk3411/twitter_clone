# frozen_string_literal: true

class TweetsController < ApplicationController
  def index
    tweets = Tweet.all.order(created_at: :desc)
    @tweets = Kaminari.paginate_array(tweets).page(params[:page]).per(10)
  end

  def show; end
end
