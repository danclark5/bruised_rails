require 'rails_helper'

RSpec.describe "Posts endpoints", type: :request do
  let!(:pending_post) { create(:post, title: 'A pending post') }
  let!(:live_post) { create(:post, :live) }

  let(:valid_params) { {post: {title: "A ad hoc title", text: "An ad hoc body", is_live: "1"} } }
  let(:invalid_params) { {post: {title: "", text: "", is_live: ""} } }
  let(:valid_update_params) { {post: {title: "A new title", text: "A new body", is_live: "0"} } }

  describe "GET index" do
    context "as an anonymous user" do
      before { log_out }

      it "only shows live posts" do
        get posts_path
        expect(response.body).to_not include("A pending post")
        expect(response.body).to include("This is a live post")
      end
    end

    context "as bruised thumb" do
      before { log_in }

      it "shows all posts" do
        get posts_path
        expect(response.body).to include("A pending post")
        expect(response.body).to include("This is a live post")
      end
    end
  end

  describe "GET show" do
    context "as an anonymous user" do
      before { log_out }

      it "shows live posts" do
        get post_path(live_post)
        expect(response).to be_successful
      end

      it "redirects from pending posts" do
        get post_path(pending_post)
        expect(response).to redirect_to(posts_path)
        follow_redirect!
        expect(response.body).to include("Post not found")
      end
    end

    context 'as bruised thumb' do
      before { log_in }

      it "shows live posts" do
        get posts_path(live_post)
        expect(response).to be_successful
      end

      it "shows pending posts" do
        get posts_path(pending_post)
        expect(response).to be_successful
      end
    end
  end

  describe "GET new" do
    context "as an anonymous user" do
      before { log_out }

      it "redirects to the login" do
        get new_post_path 
        expect(response).to redirect_to(log_in_path)
        follow_redirect!
        expect(response.body).to include("You must be logged in to access this section")
      end
    end

    context "as bruised thumb" do
      before { log_in }

      it "renders the new template" do
        get new_post_path
        expect(response).to be_successful
      end
    end
  end

  describe "GET edit" do
    context "as an anonymous user" do
      before { log_out }

      it "redirects to the login" do
        get edit_post_path(live_post)
        expect(response).to redirect_to(log_in_path)
        follow_redirect!
        expect(response.body).to include("You must be logged in to access this section")
      end
    end

    context "as bruised thumb" do
      before { log_in }

      it "returns success" do
        get edit_post_path(live_post)
        expect(response).to be_successful
      end
    end
  end

  describe "POST create" do
    context "as an anonymous user" do
      before { log_out }

      it "redirects to the login" do
        post posts_path, params: {post: {title: "A ad hoc title", text: "An ad hoc body"}}
        expect(response).to redirect_to(log_in_path)
        follow_redirect!
        expect(response.body).to include("You must be logged in to access this section")
      end
    end

    context "as bruised thumb" do
      before { log_in }

      context "with valid parameters" do
        it "add a Post" do
          expect {
            post posts_path, params: valid_params
          }.to change(Post, :count).by(1)
        end

        it "redirects to the new post" do
          post posts_path, params: valid_params
          expect(response).to redirect_to(Post.last)
          follow_redirect!
          expect(response).to be_successful 
        end
      end

      context "with invalid parameters" do
        it "does not add a Post" do
          expect {
            post posts_path, params: invalid_params
          }.to change(Post, :count).by(0)
        end
      end
    end
  end

  describe "PUT update" do
    context "as an anonymous user" do
      before { log_out }

      it "redirects to the login" do
        put post_path(live_post), params: valid_update_params
        expect(response).to redirect_to(log_in_path)
        follow_redirect!
        expect(response.body).to include("You must be logged in to access this section")
      end
    end

    context "as bruised thumb" do
      before { log_in }

      context "with valid parameters" do
        it "doesn't add a post" do
          expect {
            put post_path(live_post), params: valid_update_params
          }.to change(Post, :count).by(0)
        end

        it "updates the post" do
          put post_path(live_post), params: valid_update_params
          live_post.reload
          expect(live_post.title).to eq("A new title")
          expect(live_post.text).to eq("A new body")
          expect(live_post.is_live).to eq(false)
        end

        it "redirects to the updated post" do
          put post_path(live_post), params: valid_update_params
          expect(response).to redirect_to(live_post)
          follow_redirect!
          expect(response).to be_successful 
        end
      end
      
      context "with invalid parameters" do
        it "doesn't add a post" do
          expect {
            put post_path(live_post), params: invalid_params
          }.to change(Post, :count).by(0)
        end

        it "doesn't update the post" do
          put post_path(live_post), params: invalid_params
          live_post.reload
          expect(live_post.title).to eq("This is a live post")
          expect(live_post.text).to eq("This is the body of the post")
          expect(live_post.is_live).to eq(true)
        end
      end
    end
  end
end
