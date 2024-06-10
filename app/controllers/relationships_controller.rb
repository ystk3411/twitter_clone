# frozen_string_literal: true

class RelationshipsController < ApplicationController
  def create
    if params[:tweet_id]
      relationship = Relationship.create(follower_id: current_user.id,
                                       followed_id: Tweet.find_by(id: params[:tweet_id]).user.id)
      relationship.save
      redirect_to request.referer, notice: 'フォローしました'
    else
      p params[:id]
      relationship = Relationship.create(follower_id: current_user.id,
                                       followed_id: params[:id])
      relationship.save
      redirect_to request.referer, notice: 'フォローしました'
    end
  end

  def destroy
    if params[:tweet_id]
      relationship = Relationship.find_by(follower_id: current_user.id,
                                          followed_id: Tweet.find_by(id: params[:tweet_id]).user.id)
      relationship.destroy
      redirect_to request.referer, notice: 'フォローを解除しました'
    else
      relationship = Relationship.find_by(follower_id: current_user.id,
                                          followed_id: params[:id])
      relationship.destroy
      redirect_to request.referer, notice: 'フォローを解除しました'
    end
  end
end
