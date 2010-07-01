class Product < ActiveResource::Base
  self.site = "http://localhost:3000" 

  def self.all(*params)
    find(:all, *params)
  end

  def update_attributes(attributes)
    attributes.symbolize_keys!
    attributes.each do |name, value|
      send(name, value) if self.respond_to?(name)
    end
    save
  end

  # Dynamically create getters and setters for these properties (Only needed for new products)
  %w(name price description stock).each do |attribute|
    define_method attribute do
      attributes[attribute]
    end
  end
  
  def categories
    Category.all.delete_if { |category| !category.has_product?(self) }
  end
end
