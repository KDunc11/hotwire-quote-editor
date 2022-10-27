require "rails_helper"

RSpec.describe User, type: :model do
  it { is_expected.to respond_to(:email) }
  it { is_expected.to respond_to(:encrypted_password) }

  describe "#is_valid?" do
    subject { user.valid? }

    let(:company) { create(:company) }
    let(:user) do
      build(:user,
            company: company,
            email: email,
            encrypted_password: encrypted_password
      )
    end
    let(:email) { Faker::Internet.unique.email }
    let(:encrypted_password) { Devise::Encryptor.digest(User, Faker::Internet.password) }

    context "when email is not present" do
      let(:email) { nil }

      it { is_expected.to be false }
    end

    context "when encrypted password is not present" do
      let(:encrypted_password) { nil }

      it { is_expected.to be false }
    end

    context "when company is not present" do
      let(:company) { nil }

      it { is_expected.to be false }
    end
  end

  describe "#name" do
    let(:user) { build(:user) }

    it "returns the user's name" do
      expect(user.name).to eq(user.email.split("@").first.capitalize)
    end
  end
end
