# frozen_string_literal: true

class AddAdminToUsers < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :admin, :string
  end

  def down
    remove_column :users, :admin, :string
  end
end
