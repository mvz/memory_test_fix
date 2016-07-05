class CreateFoos < ActiveRecord::Migration
  def self.up
    create_table :foos do |t|
      t.string :name

      t.timestamps null: false
    end
  end

  def self.down
    drop_table :foos
  end
end
