# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, only: %w[show]
  def index; end

  def show
    @user = User.find(params[:id])

    tweets = @user.tweets
    @tweets = Kaminari.paginate_array(tweets).page(params[:page]).per(10)

    tweets_like = @user.likes.eager_load(:user, :tweet)
    @tweets_like = Kaminari.paginate_array(tweets_like).page(params[:page]).per(10)

    tweets_retweet = @user.retweets.eager_load(:user, :tweet)
    @tweets_retweet = Kaminari.paginate_array(tweets_retweet).page(params[:page]).per(10)

    comments = @user.tweets.eager_load(:user, :tweet).where.not(comment_id: nil)
    @comments = Kaminari.paginate_array(comments).page(params[:page]).per(10)
    
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)

    if @user.id == current_user.id
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
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
