# frozen_string_literal: true

class UsersController < ApplicationController
  def index; end

  def show
    return unless current_user

    tweets = current_user.tweets
    @tweets = Kaminari.paginate_array(tweets).page(params[:page]).per(10)

    tweets_like = current_user.likes.eager_load(:user, :tweet)
    @tweets_like = Kaminari.paginate_array(tweets_like).page(params[:page]).per(10)

    tweets_retweet = current_user.retweets.eager_load(:user, :tweet)
    @tweets_retweet = Kaminari.paginate_array(tweets_retweet).page(params[:page]).per(10)

    comments = current_user.comments.eager_load(:user, :tweet)
    @comments = Kaminari.paginate_array(comments).page(params[:page]).per(10)
  end
end
