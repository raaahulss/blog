require 'spec_helper'
require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
    describe "GET index" do
      let(:article) { create(:article, :public) }

      it "assigns @articles" do
        get :index
        expect(assigns(:articles)).to eq([article])
      end
  
      it "renders the index template" do
        get :index
        expect(response).to render_template("index")
      end
    end

    describe "GET show" do
      let(:article) { create(:article, :public) }

      it "assigns @article" do
        get :show, params: { id: article.id }
        expect(assigns(:article)).to eq(article)
      end
  
      it "renders the show template" do
        get :show, params: { id: article.id }
        expect(response).to render_template("show")
      end
    end

    describe "GET new" do
      before { request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials("dhh","secret") }
      
      it "assigns @article" do
        get :new
        expect(assigns(:article)).to be_a Article
      end
  
      it "renders the new template" do
        get :new
        expect(response).to render_template("new")
      end
    end

    describe "POST create" do
      before { request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials("dhh","secret") }

      context "with valid data" do
        let(:params) do
          {
            article: {
              title: "Test Article",
              body: "Test article body",
              status: "public"
            }
          }
        end

        it "assigns @article" do
          get :create, params: params
          expect(assigns(:article)).to be_a Article
          expect(assigns(:article).title).to eq(params.dig(:article, :title))
          expect(assigns(:article).body).to eq(params.dig(:article, :body))
          expect(assigns(:article).status).to eq(params.dig(:article, :status))
        end
    
        it "redirect to article show template" do
          get :create, params: params
          expect(response).to redirect_to("/articles/#{assigns(:article).id}")
        end
      end

      context "with invalid data" do
        let(:params) do
          {
            article: {
              body: "Test",
              status: "public"
            }
          }
        end

        it "assigns @article" do
          get :create, params: params
          expect(assigns(:article)).to be_a Article
        end
    
        it "renders the new template" do
          get :create, params: params
          expect(response).to render_template("new")
        end
      end
    end

    describe "GET edit" do
      let(:article) { create(:article, :public) }

      before { request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials("dhh","secret") }
      
      it "assigns @article" do
        get :edit, params: { id: article.id }
        expect(assigns(:article)).to eq(article)
      end
  
      it "renders the edit template" do
        get :edit, params: { id: article.id }
        expect(response).to render_template("edit")
      end
    end

    describe "PUT update" do
      before { request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials("dhh","secret") }

      context "with valid data" do
        let(:article) { create(:article, :public) }
        let(:params) do
          {
            id: article.id,
            article: {
              title: "Test Article Update",
              body: "Test article body update",
              status: "public"
            }
          }
        end

        it "assigns @article" do
          patch :update, params: params
          expect(assigns(:article)).to eq(article)
          expect(assigns(:article).title).to eq(params.dig(:article, :title))
          expect(assigns(:article).body).to eq(params.dig(:article, :body))
          expect(assigns(:article).status).to eq(params.dig(:article, :status))
        end
    
        it "redirect to article show template" do
          put :update, params: params
          expect(response).to redirect_to("/articles/#{assigns(:article).id}")
        end
      end

      context "with invalid data" do
        let(:article) { create(:article, :public) }
        let(:params) do
          {
            id: article.id,
            article: {
              body: "Test",
              status: "public"
            }
          }
        end

        it "assigns @article" do
          put :update, params: params
          expect(assigns(:article)).to eq(article)
          expect(Article.find_by(id: article.id).title).to eq(article.title)
          expect(Article.find_by(id: article.id).body).to eq(article.body)
          expect(Article.find_by(id: article.id).status).to eq(article.status)
        end
    
        it "renders the edit template" do
          put :update, params: params
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      let(:article) { create(:article, :public) }

      before { request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials("dhh","secret") }

      it "assigns @article" do
        delete :destroy, params: { id: article.id }
        expect(Article.find_by(id: article.id)).to be_nil
      end
  
      it "redirect to root path" do
        delete :destroy, params: { id: article.id }
        expect(response).to redirect_to("/")
      end
    end
  end
  