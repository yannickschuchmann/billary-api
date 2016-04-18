class AddInvoicedFlagToTimeEntries < ActiveRecord::Migration[5.0]
  def change
    add_column :time_entries, :invoiced, :boolean, default: false
  end
end
