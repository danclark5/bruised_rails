class HomeController < ApplicationController
  def index
    @posts = Post.order(:created_at).limit(5)
  end
end
