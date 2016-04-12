class ChangeTokensFieldOfUsers < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :tokens, :text
  end
end
