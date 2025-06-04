include Pundit::Authorization

class ForumPostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_forum_post, only: [:show, :edit, :update, :destroy]

  def index
    @forum_posts = ForumPost.includes(:user).order(created_at: :desc)
  end

  def show
    @comment = Comment.new
  end

  def new
    @forum_post = ForumPost.new
  end

  def create
    @forum_post = current_user.forum_posts.build(forum_post_params)
    if @forum_post.save
      redirect_to @forum_post, notice: 'Post was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @forum_post
  end

  def update
    authorize @forum_post
    if @forum_post.update(forum_post_params)
      redirect_to @forum_post, notice: 'Post was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @forum_post
    @forum_post.destroy
    redirect_to forum_posts_path, notice: 'Post was successfully deleted.'
  end

  private

  def set_forum_post
    @forum_post = ForumPost.find(params[:id])
  end

  def forum_post_params
    params.require(:forum_post).permit(:title, :content)
  end
end
