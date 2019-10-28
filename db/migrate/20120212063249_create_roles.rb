class CreateRoles < ActiveRecord::Migration[5.2]
  def self.up
    create_table :roles do |t|

      t.string :name,  default: ""
      t.string :title, default: ""
      t.text :description
      t.text :the_role, null: false

      t.timestamps
    end
  end

  def self.down
    drop_table :roles
  end
end
