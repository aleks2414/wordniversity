class CreateUniversities < ActiveRecord::Migration
  def change
    create_table :universities do |t|
      t.references :user, index: true, foreign_key: true
      t.string :url
      t.string :name
      t.string :country_code
      t.text :description
      t.string :image
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :facebook
      t.string :twitter
      t.string :linkedin

      t.timestamps null: false
    end
  end
end
