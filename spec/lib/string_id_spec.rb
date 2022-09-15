require "rails_helper"

RSpec.describe StringId do
  describe "#generate" do
    subject { StringId.new }

    it "returns an acceptable token" do
      expect(subject.generate.length).to eq 6
    end

    context "When blocklisted" do
      let(:bad_token) { "analxx" }
      let(:good_token) { "GDKZXj" }

      before do
        allow(subject).to receive(:sample_token).and_return(bad_token)
        allow(subject).to receive(:sample_token).and_return(good_token)
      end

      it "returns an acceptable token" do
        token = subject.generate
        expect(token).to eq good_token
      end
    end
  end
end
