require "rails_helper"

RSpec.describe "/quotes", type: :request do
  let(:attributes) { { name: name } }

  let(:name) { Faker::TvShows::RickAndMorty.quote }
  let(:quote) { create(:quote, name: name) }

  describe "GET #index" do
    it "renders a successful response" do
      get quotes_path
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get quote_path(quote.oid)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_quote_path
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      get edit_quote_path(quote.oid)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Quote" do
        expect {
          post quotes_path, params: { quote: attributes }
        }.to change(Quote, :count).by(1)
      end

      it "redirects to the created Quotes list" do
        post quotes_path, params: { quote: attributes }
        expect(response).to redirect_to(quotes_path)
      end
    end

    context "with invalid parameters" do
      let(:name) { "" }

      it "does not create a new Quote" do
        expect {
          post quotes_path, params: { quote: attributes }
        }.to change(Quote, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post quotes_path, params: { quote: attributes }
        expect(response).to be_successful
      end
    end
  end
end