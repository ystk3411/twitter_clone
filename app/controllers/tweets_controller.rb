# frozen_string_literal: true

class TweetsController < ApplicationController
  def index
    tweets = Tweet.all.order(created_at: :desc)
    tweets_following = Tweet.where(user_id:current_user.id)
    @tweets = Kaminari.paginate_array(tweets).page(params[:page]).per(10)
    @tweets_following = Kaminari.paginate_array(tweets_following).page(params[:page]).per(10)
    p tweets_following
  end

  def show; end
end
