# frozen_string_literal: true

class UsersAdminNullFalse < ActiveRecord::Migration[7.0]
  def up
    change_table :users, bulk: true do |t|
      t.change :admin, :string, null: false
    end
  end

  def down
    change_table :users, bulk: true do |t|
      t.change :admin, :string, null: true
    end
  end
end
