class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.float :star, default: 3
      t.references :user, index: true, foreign_key: true
      t.references :university, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
