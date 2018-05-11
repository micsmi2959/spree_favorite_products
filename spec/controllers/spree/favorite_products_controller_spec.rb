require 'spec_helper'

describe Spree::FavoriteProductsController do

  let(:proxy_object) { Object.new }

  shared_examples_for "request which requires user authentication" do
    it "authenticates user" do
      expect(controller).to receive(:authenticate_spree_user!)
      send_request
    end
  end

  shared_examples_for "request which finds favorite product" do
    it "finds favorite product" do
      expect(@favorites).to receive(:with_product_id).with('id')
      send_request
    end

    it "assigns @favorite" do
      send_request
      expect(assigns(:favorite)).to eq(@favorite)
    end
  end

  describe 'POST create' do
    def send_request
      post :create, params: { id: 1 }, as: :js
    end

    before(:each) do
      @favorite = mock_model(Spree::Favorite, save: true)
      allow(controller).to receive(:authenticate_spree_user!).and_return(true)
      allow(Spree::Favorite).to receive(:new).and_return(@favorite)
      @user = mock_model(Spree::User, favorites: Spree::Favorite, generate_spree_api_key!: false, last_incomplete_spree_order: nil)
      allow(controller).to receive(:spree_current_user).and_return(@user)
    end

    it_behaves_like "request which requires user authentication"


    it "creates favorite" do
      expect(Spree::Favorite).to receive(:new).with(product_id: 1)
      send_request
    end

    it "saves favorite" do
      expect(@favorite).to receive(:save)
      send_request
    end

    context "when favorite saved successfully" do
      it "renders create" do
        send_request
        expect(response).to render_template(:create)
      end

      it "should assign success message" do
        send_request
        expect(assigns(:message)).to eq("Product has been successfully marked as favorite")
      end
    end

    context "when favorite not saved sucessfully" do
      before(:each) do
        allow(@favorite).to receive(:save).and_return(false)
        allow(@favorite).to receive(:errors).and_return(proxy_object)
        allow(proxy_object).to receive(:full_messages).and_return(["Product already marked as favorite"])
      end

      it "renders create template" do
        send_request
        expect(response).to render_template(:create)
      end

      it "should assign error message" do
        send_request
        expect(assigns(:message)).to eq("Product already marked as favorite")
      end
    end
  end

  describe 'GET index' do
    def send_request
      get :index, params: { page: 'current_page' }
    end

    before(:each) do
      @favorite_products = double('favorite_products')
      allow(@favorite_products).to receive(:page).and_return(@favorite_products)
      allow(@favorite_products).to receive(:per).and_return(@favorite_products)
      allow(Spree::Config).to receive(:favorite_products_per_page).and_return('favorite_products_per_page')
      @user = mock_model(Spree::User, favorite_products: @favorite_products, generate_spree_api_key!: false, last_incomplete_spree_order: nil)
      allow(controller).to receive(:authenticate_spree_user!).and_return(true)
      allow(controller).to receive(:spree_current_user).and_return(@user)
    end

    it "authenticates user" do
      expect(controller).to receive(:authenticate_spree_user!)
      send_request
    end

    it "finds favorite products of current user" do
      expect(@user).to receive(:favorite_products)
      send_request
    end

    it "paginates favorite products" do
      expect(@favorite_products).to receive(:page).with('current_page')
      send_request
    end

    it "shows Spree::Config.favorite_products_per_page" do
      expect(@favorite_products).to receive(:per).with('favorite_products_per_page')
      send_request
    end

    it "assigns @favorite_products" do
      send_request
      expect(assigns(:favorite_products)).to eq(@favorite_products)
    end
  end

  describe 'destroy' do
    def send_request(params = {})
      post :destroy, params: params.merge({method: :delete, id: 'id'}), as: :js
    end

    before do
      @favorite = mock_model(Spree::Favorite)
      @favorites = double('spree_favorites')
      allow(@favorites).to receive(:with_product_id).and_return([@favorite])
      @user = mock_model(Spree::User, favorites: @favorites, generate_spree_api_key!: false, last_incomplete_spree_order: nil)
      allow(controller).to receive(:authenticate_spree_user!).and_return(true)
      allow(controller).to receive(:spree_current_user).and_return(@user)
    end

    it_behaves_like "request which requires user authentication"
    it_behaves_like "request which finds favorite product"

    context 'when @favorite  exist' do
      before(:each) do
        controller.instance_variable_set(:@favorite, @favorite)
      end

      it 'destroys' do
        expect(@favorite).to receive(:destroy)
        send_request
      end

      context 'when destroyed successfully' do
        before(:each) do
          allow(@favorite).to receive(:destroy).and_return(true)
        end

        it "sets @success to true" do
          send_request
          expect(assigns(:success)).to eq(true)
        end
      end

      context 'when not destroyed' do
        before(:each) do
          allow(@favorite).to receive(:destroy).and_return(false)
        end

        it 'sets @success to false' do
          send_request
          expect(assigns(:success)).to eq(false)
        end
      end
    end

  end
end
