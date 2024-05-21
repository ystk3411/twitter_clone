# frozen_string_literal: true

class TweetsController < ApplicationController
  def index
    @tweet = Tweet.new

    tweets = Tweet.all.order(created_at: :desc)
    @tweets = Kaminari.paginate_array(tweets).page(params[:page]).per(10)

    return unless current_user

    tweets_following = Tweet.where(user_id: current_user.active_relationships.pluck(:followed_id))
    @tweets_following = Kaminari.paginate_array(tweets_following).page(params[:page]).per(10)
  end

  def show; end

  def create
    tweet = current_user.tweets.build(tweet_params)
    tweet.user_id = current_user.id
    
    if tweet.save
      redirect_to root_path, notice: '投稿しました'
    else
      redirect_to root_path, error: '投稿に失敗しました'
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:content, :image)
  end
end
