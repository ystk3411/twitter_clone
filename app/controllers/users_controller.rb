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

    comments = current_user.tweets.eager_load(:user, :tweet).where.not(comment_id: nil)
    @comments = Kaminari.paginate_array(comments).page(params[:page]).per(10)

    @user = current_user
  end

  def edit
    return unless current_user

    @user = current_user
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user), notice: 'プロフィールを更新しました'
    else
      flash.now[:danger] = 'プロフィールの更新に失敗しました'
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :comment, :header, :profile)
  end
end
