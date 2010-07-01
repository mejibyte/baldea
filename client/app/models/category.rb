class Category < ActiveRecord::Base
  validates_presence_of :name
  serialize :product_ids, Array
  
  def products
    Product.all(:params => { :ids => product_ids })
  end
  
  def product_ids=(array)
    self[:product_ids] = array.collect { |id| id.to_i }
  end
  
  def product_ids
    self[:product_ids] || []
  end
  
  def has_product?(product)
    product_ids.include?(product.id)
  end
  
end
