# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    like = current_user.likes.build
    like.tweet_id = params[:tweet_id]
    like.save
    redirect_to request.referer
  end

  def destroy
    like = current_user.likes.eager_load(:tweet).find_by(tweet_id:params[:tweet_id])
    like.destroy
    redirect_to request.referer
  end
end
