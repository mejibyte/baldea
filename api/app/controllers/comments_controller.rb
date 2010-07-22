class CommentsController < ApplicationController
  before_filter :load_product
  
  def index
    @comments = @product.comments
    render :layout => false
  end
  
  def create
    @comment = @product.comments.build(params[:comment])
    @comment.save

    @comments = @product.reload.comments
    render :action => "index"
  end
  
  protected
  
  def load_product
    @product = Product.find(params[:pretty_product_id])
  end
end
