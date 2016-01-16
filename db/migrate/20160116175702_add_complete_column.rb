class AddCompleteColumn < ActiveRecord::Migration
  def change
    add_column :works, :complete, :boolean, default: false
  end
end
