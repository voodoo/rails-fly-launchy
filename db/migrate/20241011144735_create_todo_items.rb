class CreateTodoItems < ActiveRecord::Migration[7.0]
  def change
    create_table :todo_items do |t|
      t.string :title, null: false
      t.text :description
      t.integer :state, default: 0
      t.datetime :due_date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :todo_items, :state
    add_index :todo_items, :due_date
  end
end