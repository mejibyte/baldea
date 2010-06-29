require 'pp'

class Product < ActiveRecord::Base

  def self.columns() @columns ||= []; end
 
  def self.column(name, sql_type = nil, default = nil, null = true)
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type.to_s, null)
  end
  
  column :price, :integer
  column :name, :string
  column :stock, :integer
  column :description, :text
  column :created_at, :datetime
  column :updated_at, :datetime
  column :id, :integer
  
  def self.find(*args)
    case args.first
    when :first then raise "Not implemented yet"
    when :last  then raise "Not implemented yet"
    when :all   then raise "Not implemented yet"
    else             find_from_id(args)
    end
  end
  
  def self.find_from_id(*args)
    # Pull the product info from the API, and build it from that.
    id = args.first
    fetched = HTTParty.get("http://localhost:3000/products/#{id}.xml").body
    attributes = Hash.from_xml(fetched)["product"]
    product = Product.new(attributes)
    product.id = attributes["id"]
    product    
  end
  
end
