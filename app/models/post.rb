class Post < ApplicationRecord
  def self.markdown
    Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  end
end
