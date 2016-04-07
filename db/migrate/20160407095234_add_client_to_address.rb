class AddClientToAddress < ActiveRecord::Migration[5.0]
  def change
    add_reference :addresses, :client, foreign_key: true
  end
end
