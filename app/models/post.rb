class Post < ApplicationRecord
  def self.markdown
    Redcarpet::Markdown.new(Redcarpet::Render::HTML, fenced_code_blocks: true)
  end
end
