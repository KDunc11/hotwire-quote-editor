require "rails_helper"

RSpec.describe Quote, type: :model do
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:oid) }

  describe "#is_valid?" do
    subject { quote.valid? }

    let(:quote) { build(:quote, name: name) }
    let(:name) { Faker::TvShows::RickAndMorty.quote }

    context "when name is not present" do
      let(:name) { nil }

      it { is_expected.to be false }
    end

    context "when name is empty" do
      let(:name) { "" }

      it { is_expected.to be false }
    end

    context "when name is present" do
      context "when name is unique" do
        it { is_expected.to be true }
      end

      context "when name is not unique" do
        before { create(:quote, name: name) }

        it { is_expected.to be false }
      end
    end
  end
end
