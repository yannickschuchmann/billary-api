class AddUserToTimeEntries < ActiveRecord::Migration[5.0]
  def change
    add_reference :time_entries, :user, foreign_key: true
  end
end
