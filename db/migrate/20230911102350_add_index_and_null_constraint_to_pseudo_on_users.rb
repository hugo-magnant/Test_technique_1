class AddIndexAndNullConstraintToPseudoOnUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_null :users, :pseudo, false
    add_index :users, :pseudo, unique: true
  end
end
