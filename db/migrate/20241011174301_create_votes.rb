class CreateVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :votes do |t|
      t.references :story, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :votes, [:user_id, :story_id], unique: true
    add_column :stories, :votes_count, :integer, default: 0, null: false
  end
end
