require "rails_helper"

RSpec.describe Company, type: :model do
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:oid) }

  describe "#is_valid?" do
    subject { company.valid? }

    let(:company) { build(:company, name: name) }
    let(:name) { Faker::Company.unique.name }

    context "when name is not present" do
      let(:name) { "" }

      it { is_expected.to be false }
    end

    context "when name is not unique" do
      before { create(:company, name: name) }

      it { is_expected.to be false }
    end

    context "when name is unique" do
      it { is_expected.to be true }
    end
  end
end
