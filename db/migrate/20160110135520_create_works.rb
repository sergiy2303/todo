class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.references :user, index: true
      t.string :description

      t.timestamps null: false
    end
  end
end
