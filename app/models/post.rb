require 'bruised_thumb_render'

class Post < ApplicationRecord
  validates :title, presence: true
  validates :text, presence: true
  validates :is_live, :inclusion => {:in => [true, false]}

  def self.markdown
    Redcarpet::Markdown.new(BruisedThumbRender, fenced_code_blocks: true)
  end

  def post_snippet(char, char_count)
    return self.text if self.text.count(char) <= char_count
    break_point = (0..self.text.size).select {|i| self.text[i] == char}[char_count-1]
    self.text[0..break_point - 1] + "..."
  end
end
