require 'rails_helper'

RSpec.describe HomeHelper, type: :helper do
  describe "#post_snippet" do
    let(:example_post) { "This is a test post to see how this handles. We're only "\
                           "going to do a few lines just to see how this works. If "\
                           "it does then the test will pass."}
    let(:example_post_snippet) { "This is a test post to see how this handles. We're only "\
                                 "going to do a few lines just to see how this works. If..."}
    it "returns a portion of the post" do
      expect(helper.post_snippet(example_post, 25)).to eq(example_post_snippet)
    end

    it "returns the whole string when it's too short" do
      expect(helper.post_snippet(example_post, 250)).to eq(example_post)
    end
  end
end
