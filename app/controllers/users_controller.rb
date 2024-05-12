# frozen_string_literal: true

class UsersController < ApplicationController
  def index; end

  def show
    return unless current_user

    tweets = Tweet.where(user_id: current_user.id).order(created_at: :desc)
    @tweets = Kaminari.paginate_array(tweets).page(params[:page]).per(10)

    tweets_like = Like.where(user_id: current_user.id)
    @tweets_like = Kaminari.paginate_array(tweets_like).page(params[:page]).per(10)

    tweets_retweet = Retweet.where(user_id: current_user.id)
    @tweets_retweet = Kaminari.paginate_array(tweets_retweet).page(params[:page]).per(10)

    comments = Comment.where(user_id: current_user.id)
    @comments = Kaminari.paginate_array(comments).page(params[:page]).per(10)
  end
end
