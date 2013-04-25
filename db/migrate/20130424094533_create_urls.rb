class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :full
      t.string :short
      t.integer :click_count, :default => 0
      t.references :users
    end
  end
end
