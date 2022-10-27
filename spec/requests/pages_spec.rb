require "rails_helper"

RSpec.describe "Pages", type: :request do
  describe "GET /home" do
    context "when user is not signed in" do
      it "returns a successful response" do
        get root_path
        expect(response).to be_successful
      end
    end

    context "when user is signed in" do
      let(:company) { create(:company) }
      let(:user) { create(:user, password: "password", company: company) }

      before do
        sign_in user
      end

      it "redirects to quotes path" do
        get root_path
        expect(response).to redirect_to(quotes_path)
      end
    end
  end
end
