class ChangeInvoicedFlagForTimeEntry < ActiveRecord::Migration[5.0]
  def change
    remove_column :time_entries, :invoiced
    add_reference :time_entries, :invoice, foreign_key: true
  end
end
