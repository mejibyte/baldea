class Product < ActiveResource::Base
  self.site = "http://localhost:3000" 
  
  def self.all(*params)
    find(:all, *params)
  end
end
