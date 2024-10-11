class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :description
      t.integer :state, default: 0
      t.datetime :due_date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :tasks, :state
    add_index :tasks, :due_date
  end
end