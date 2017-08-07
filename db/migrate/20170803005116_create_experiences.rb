class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.string :experience
      t.references :user, index: true, foreign_key: true
      t.references :university, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
