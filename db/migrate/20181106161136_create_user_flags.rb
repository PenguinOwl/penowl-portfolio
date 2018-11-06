class CreateUserFlags < ActiveRecord::Migration[5.2]
  def change
    create_table :user_flags do |t|
      t.string :user
      t.string :content

      t.timestamps
    end
  end
end
