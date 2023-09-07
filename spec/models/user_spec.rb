require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do

    # Test pour vérifier si un utilisateur est considéré comme valide avec un pseudo valide.
    it "is valid with a valid pseudo" do
      user = build(:user)
      expect(user).to be_valid
    end

    # Test pour vérifier si un utilisateur est invalide sans pseudo.
    it "is not valid without a pseudo" do
      user = build(:user, pseudo: nil)
      expect(user).not_to be_valid
    end

    # Test pour vérifier si un utilisateur est invalide si le pseudo n'a pas exactement 3 caractères.
    it "is not valid if pseudo is not 3 characters long" do
      user = build(:user, pseudo: "AB")
      expect(user).not_to be_valid
    end

    # Test pour vérifier si un utilisateur est invalide si le pseudo contient des lettres minuscules.
    it "is not valid if pseudo contains lowercase letters" do
      user = build(:user, pseudo: "ABc")
      expect(user).not_to be_valid
    end
  end
end
