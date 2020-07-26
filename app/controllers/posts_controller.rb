class PostsController < ApplicationController
  before_action :require_bruised_thumb, only: [:new, :create, :edit, :update]
  def index
    @posts = Post.all if is_bruised_thumb?
    @posts = Post.where("is_live is true").all unless is_bruised_thumb?
  end

  def show
    @post = Post.find_by!(id: params[:id]) if is_bruised_thumb?
    @post = Post.find_by!(id: params[:id], is_live: true) unless is_bruised_thumb?
    @twitter_title = @post.title
    @twitter_description = @post.post_snippet('.', 1)
  rescue ActiveRecord::RecordNotFound
    redirect_to posts_path, alert: 'Post not found!'
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post
    else
      render 'new'
    end

  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :text, :is_live)
  end
end
