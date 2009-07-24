class AddRolesToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :role_type, :integer
  end

  def self.down
    remove_column :users, :role_type
  end
end
