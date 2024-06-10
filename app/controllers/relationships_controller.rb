# frozen_string_literal: true

class RelationshipsController < ApplicationController
  def create
    if params[:tweet_id]
      relationship = Relationship.create(follower_id: current_user.id,
                                         followed_id: Tweet.find_by(id: params[:tweet_id]).user.id)
    else
      Rails.logger.debug params[:id]
      relationship = Relationship.create(follower_id: current_user.id,
                                         followed_id: params[:id])
    end
    relationship.save
    redirect_to request.referer, notice: 'フォローしました'
  end

  def destroy
    relationship = if params[:tweet_id]
                     Relationship.find_by(follower_id: current_user.id,
                                          followed_id: Tweet.find_by(id: params[:tweet_id]).user.id)
                   else
                     Relationship.find_by(follower_id: current_user.id,
                                          followed_id: params[:id])
                   end
    relationship.destroy
    redirect_to request.referer, notice: 'フォローを解除しました'
  end
end
