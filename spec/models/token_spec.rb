# frozen_string_literal: true

require "rails_helper"

RSpec.describe Token, type: :model do
  it { is_expected.to respond_to(:token) }

  describe "#is_valid?" do
    subject { token.valid? }

    let(:token) { build(:token, token: token_string) }
    let(:token_string) { StringId.new.generate }

    context "when token is nil" do
      let(:token_string) { nil }

      it { is_expected.to be false }
    end

    context "when token is empty" do
      let(:token_string) { "" }

      it { is_expected.to be false }
    end

    context "when token is not unique" do
      before { create(:token, token: token_string) }

      it { is_expected.to be false }
    end

    context "when token is unique" do
      it { is_expected.to be true }
    end
  end
end
