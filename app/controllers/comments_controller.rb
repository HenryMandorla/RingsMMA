class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_forum_post
  before_action :set_comment, only: [:destroy]

  def create
    @comment = @forum_post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @forum_post, notice: 'Comment was successfully created.'
    else
      redirect_to @forum_post, alert: 'Error creating comment.'
    end
  end

  def destroy
    authorize @comment
    @comment.destroy
    redirect_to @forum_post, notice: 'Comment was successfully deleted.'
  end

  private

  def set_forum_post
    @forum_post = ForumPost.find(params[:forum_post_id])
  end

  def set_comment
    @comment = @forum_post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end 