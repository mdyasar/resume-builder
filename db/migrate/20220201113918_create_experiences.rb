class CreateExperiences < ActiveRecord::Migration[6.1]
  def change
    create_table :experiences do |t|
      t.string :company
      t.string :position
      t.date :startdate
      t.date :enddate
      t.text :description
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
