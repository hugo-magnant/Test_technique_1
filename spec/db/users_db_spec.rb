require "rails_helper"

RSpec.describe User, type: :model do
  describe "pseudo validations" do
    let!(:user) { create(:user, pseudo: "ABC") }

    context "uniqueness" do
      it "does not allow duplicate pseudos" do
        duplicate_user = build(:user, pseudo: "ABC")
        expect(duplicate_user).not_to be_valid
        expect(duplicate_user.errors.messages[:pseudo]).to include("has already been taken")
      end
    end

    context "presence" do
      it "does not allow NULL values" do
        null_user = build(:user, pseudo: nil)
        expect(null_user).not_to be_valid
        expect(null_user.errors.messages[:pseudo]).to include("can't be blank")
      end

      it "requires a pseudo to be present" do
        absent_user = User.new
        expect(absent_user).not_to be_valid
        expect(absent_user.errors.messages[:pseudo]).to include("can't be blank")
      end
    end

    context "database constraints" do
      it "has an index on pseudo" do
        pseudo_index = ActiveRecord::Base.connection.indexes(:users).find { |i| i.columns.include?("pseudo") }
        expect(pseudo_index).not_to be_nil
      end

      it "rejects duplicate pseudos at the database level" do
        valid_user = create(:user, pseudo: "XYZ")
        expect {
          User.connection.execute("INSERT INTO users (pseudo) VALUES ('XYZ')")
        }.to raise_error(ActiveRecord::StatementInvalid)
      end

      it "rejects pseudos that are not uppercase at the database level" do
        # Assuming you've implemented such a constraint at the DB level
        expect {
          User.connection.execute("INSERT INTO users (pseudo) VALUES ('xyz')")
        }.to raise_error(ActiveRecord::StatementInvalid)
      end

      it "rejects pseudos that don't adhere to a specific length at the database level" do
        # Assuming pseudos must be 3 characters long and you've implemented such a constraint at the DB level
        expect {
          User.connection.execute("INSERT INTO users (pseudo) VALUES ('AB')")
        }.to raise_error(ActiveRecord::StatementInvalid)

        expect {
          User.connection.execute("INSERT INTO users (pseudo) VALUES ('ABCD')")
        }.to raise_error(ActiveRecord::StatementInvalid)
      end

      it "ensures NOT NULL constraint for pseudo" do
        expect {
          User.connection.execute("INSERT INTO users (pseudo) VALUES (NULL)")
        }.to raise_error(ActiveRecord::StatementInvalid)
      end
    end
  end
end
