# frozen_string_literal: true

class TweetsController < ApplicationController
  def index
    tweets = Tweet.all.order(created_at: :desc)
    @tweets = Kaminari.paginate_array(tweets).page(params[:page]).per(10)

    return unless current_user

    tweets_following = Tweet.where(user_id: current_user.active_relationships.pluck(:followed_id))
    @tweets_following = Kaminari.paginate_array(tweets_following).page(params[:page]).per(10)
  end

  def show; end
end
