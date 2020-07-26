class HomeController < ApplicationController
  def index
    @posts = Post.all if is_bruised_thumb?
    @posts = Post.where("is_live is true").all unless is_bruised_thumb?
    @posts = @posts.order(created_at: :desc).limit(5)
  end
end
