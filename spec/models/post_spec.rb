require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "#post_snippet" do
    let(:example_post) { Post.new(text: "This is a test post to see how this handles. We're only "\
                           "going to do a few lines just to see how this works. If "\
                           "it does then the test will pass.") }
    let(:example_post_snippet) { "This is a test post to see how this handles. We're only "\
                                 "going to do a few lines just to see how this works. If..."}
    it "returns a portion of the post" do
      expect(example_post.post_snippet(' ', 25)).to eq(example_post_snippet)
    end

    it "returns the whole string when it's too short" do
      expect(example_post.post_snippet(' ', 250)).to eq(example_post.text)
    end
  end
end
