class CreateTimeEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :time_entries do |t|
      t.belongs_to :project, foreign_key: true
      t.boolean :manual
      t.timestamp :started_at
      t.timestamp :stopped_at

      t.timestamps
    end
  end
end
