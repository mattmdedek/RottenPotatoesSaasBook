class AddTimestamps < ActiveRecord::Migration
  def up
    change_table :reviews do |t|
      t.timestamps
    end
  end

  def down
    remove_column :reviews, :created_at
    remove_column :reviews, :updated_at
  end
end
