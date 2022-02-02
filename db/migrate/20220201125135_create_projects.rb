class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :url
      t.string :tech_stack
      t.text :description
      t.references :experience, null: false, foreign_key: true

      t.timestamps
    end
  end
end
