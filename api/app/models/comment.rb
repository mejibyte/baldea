class Comment < ActiveRecord::Base
  belongs_to :product
  validates_presence_of :content, :product_id
end
