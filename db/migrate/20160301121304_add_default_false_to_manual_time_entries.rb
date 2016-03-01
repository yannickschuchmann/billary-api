class AddDefaultFalseToManualTimeEntries < ActiveRecord::Migration[5.0]
  def change
    change_column :time_entries, :manual, :boolean, :default => false
  end
end
