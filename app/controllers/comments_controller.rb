class CommentsController < ApplicationController

  def show
    @comment = Comment.find(params[:id])
  end

  def create
    comment = current_user.comments.build(comment_params)
    comment.tweet_id = params[:tweet_id]

    if comment.save
      redirect_to tweet_comment_path(comment.tweet_id,comment)
    else
      redirect_to request.referer, error: '投稿に失敗しました'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content,:image)
  end
end
