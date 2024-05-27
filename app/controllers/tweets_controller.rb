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

  def show
    @tweet = Tweet.find(params[:id])
    @comment = Tweet.new
    @comments = @tweet.comments.eager_load(:user)

    return unless current_user

    return if ReadCount.find_by(user_id: current_user.id, tweet_id: @tweet.id)

    current_user.read_counts.create(tweet_id: @tweet.id)
  end

  def create
    tweet = current_user.tweets.build(tweet_params)
    tweet.user_id = current_user.id
    tweet.comment_id = params[:tweet_id] if params[:tweet_id]

    if tweet.save
      if tweet.comments
        redirect_to request.referer, notice: '返信をツイートしました'
      else
        redirect_to root_path, notice: '投稿しました'
      end
    else
      redirect_to root_path, error: '投稿に失敗しました'
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:content, :image)
  end
end
