module HomeHelper
  def post_snippet(post, space_count)
    return post if post.count(' ') <= space_count
    break_point = (0..post.size).select {|i| post[i] == ' '}[space_count-1]
    post[0..break_point - 1] + "..."
  end
end
