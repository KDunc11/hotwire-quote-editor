# frozen_string_literal: true

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
        expect do
          post quotes_path, params: { quote: attributes }
        end.to change(Quote, :count).by(1)
      end

      it "redirects to the created Quotes list" do
        post quotes_path, params: { quote: attributes }
        expect(response).to redirect_to(quotes_path)
      end
    end

    context "with invalid parameters" do
      let(:name) { "" }

      it "does not create a new Quote" do
        expect do
          post quotes_path, params: { quote: attributes }
        end.to change(Quote, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post quotes_path, params: { quote: attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    let(:updated_attributes) { { name: updated_name } }

    context "with valid parameters" do
      let(:updated_name) { "New Name" }

      it "updates the requested quote" do
        patch quote_path(quote.oid), params: { quote: updated_attributes }
        quote.reload
        expect(quote.name).to eq(updated_name)
      end

      it "redirects to the Quotes list" do
        patch quote_path(quote.oid), params: { quote: updated_attributes }
        quote.reload
        expect(response).to redirect_to(quotes_path)
      end
    end

    context "with invalid parameters" do
      let(:updated_name) { "" }

      it "renders a successful response (i.e. to display the 'edit' template)" do
        patch quote_path(quote.oid), params: { quote: updated_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested quote" do
      quote
      expect do
        delete quote_path(quote.oid)
      end.to change(Quote, :count).by(-1)
    end

    it "redirects to the Quotes list" do
      delete quote_path(quote.oid)
      expect(response).to redirect_to(quotes_path)
    end
  end
end
