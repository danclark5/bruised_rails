class PostsController < ApplicationController
  before_action :require_bruised_thumb, only: [:new, :create, :edit, :update]
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
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
  end

  def update
  end

  private
  def post_params
    params.require(:post).permit(:title, :text)
  end
end
