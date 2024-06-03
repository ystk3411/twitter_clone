class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def create
    bookmark = current_user.book_marks.build(tweet_id:params[:tweet_id])
    bookmark.save
    redirect_to request.referer
  end

  def destroy
    bookmark = current_user.book_marks.find_by(tweet_id:params[:tweet_id])
    bookmark.destroy
    redirect_to request.referer
  end
end
