# frozen_string_literal: true

class LikesController < ApplicationController

  def create
    like = current_user.likes.build
    like.tweet_id = params[:tweet_id]
    like.save
    redirect_to request.referer
  end

  def destroy
  end
end
