class RelationshipsController < ApplicationController
  def create
    relationship = Relationship.create(follower_id:current_user.id,followed_id:Tweet.find_by(id:params[:tweet_id]).user.id)
    relationship.save
    redirect_to request.referer, notice: 'フォローしました'
  end

  def destroy
    relationship = Relationship.find_by(follower_id:current_user.id,followed_id:Tweet.find_by(id:params[:tweet_id]).user.id)
    relationship.destroy
    redirect_to request.referer, notice: 'フォローを解除しました' 
  end
end
