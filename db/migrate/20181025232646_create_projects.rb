class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :text
      t.string :date
      t.string :imagelink

      t.timestamps
    end
  end
end
