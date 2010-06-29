class Product < ActiveRecord::Base
  validates_presence_of :name, :price, :description, :stock
  validates_numericality_of :price, :stock, :only_integer => true
end
