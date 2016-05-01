class AddColummToUser < ActiveRecord::Migration
  def change
    add_column :users, :profile, :text
  end
end
