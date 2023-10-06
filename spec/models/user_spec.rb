require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) { User.new(pseudo: "ABC") }

  it "is valid with a 3-letter uppercase pseudo" do
    expect(user).to be_valid
  end

  it "is invalid without a pseudo" do
    user.pseudo = nil
    expect(user).not_to be_valid
  end

  it "is invalid with a pseudo less than 3 characters" do
    user.pseudo = "AB"
    expect(user).not_to be_valid
  end

  it "is invalid with a pseudo more than 3 characters" do
    user.pseudo = "ABCD"
    expect(user).not_to be_valid
  end

  it "is invalid with a pseudo that contains lowercase letters" do
    user.pseudo = "AbC"
    expect(user).not_to be_valid
  end

  it "is invalid with a pseudo that contains numbers" do
    user.pseudo = "A1C"
    expect(user).not_to be_valid
  end
end
