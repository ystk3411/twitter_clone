class RetweetsController < ApplicationController
  before_action :authenticate_user!

  def create
    retweet = current_user.retweets.build
    retweet.tweet_id = params[:tweet_id]
    retweet.save
    redirect_to request.referer
  end

  def destroy
    retweet = current_user.retweets.find_by(tweet_id: params[:tweet_id])
    retweet.destroy
    redirect_to request.referer
  end
end
