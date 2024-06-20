# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    tweet = Tweet.find(params[:tweet_id])
    like = current_user.likes.build
    like.tweet_id = params[:tweet_id]
    like.save
    tweet.create_notification_like!(current_user)
    redirect_to request.referer
  end

  def destroy
    like = current_user.likes.find_by(tweet_id: params[:tweet_id])
    like.destroy
    redirect_to request.referer
  end
end
