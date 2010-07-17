class AddColorAndSizeToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :color, :string
    add_column :products, :size, :string
  end

  def self.down
    remove_column :products, :size
    remove_column :products, :color
  end
end
