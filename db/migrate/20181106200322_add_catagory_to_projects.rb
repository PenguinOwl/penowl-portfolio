class AddCatagoryToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :catagory, :string
  end
end
