require 'spec_helper'
require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe "POST create" do
    let(:article) { create(:article, :public) }

    before { request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials("dhh","secret") }

    let(:params) do
      {
        article_id: article.id,
        comment: {
          commenter: "A fellow dev",
          body: "I agree !!!",
          status: "public"
        }
      }
    end

    it "assigns @article and @comment" do
      get :create, params: params
      expect(assigns(:article)).to eq(article)
      expect(assigns(:comment)).to be_a Comment
      expect(assigns(:comment).commenter).to eq(params.dig(:comment, :commenter))
      expect(assigns(:comment).body).to eq(params.dig(:comment, :body))
      expect(assigns(:comment).status).to eq(params.dig(:comment, :status))
    end

    it "redirect to article show template" do
      get :create, params: params
      expect(response).to redirect_to("/articles/#{assigns(:article).id}")
    end
  end

  describe "DELETE destroy" do
    let(:article) { create(:article, :public) }
    let(:comment) { create(:comment, :public, article_id: article.id) }

    before { request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials("dhh","secret") }

    it "assigns @article and @comment" do
      delete :destroy, params: { id: comment.id, article_id: article.id }
      expect(Comment.find_by(id: comment.id)).to be_nil
    end

    it "redirect to article path" do
      delete :destroy, params: { id: comment.id, article_id: article.id }
      expect(response).to redirect_to("/articles/#{assigns(:article).id}")
    end
  end
end
