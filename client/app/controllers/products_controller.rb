class ProductsController < ApplicationController
  before_filter :load_product, :except => [:index, :new, :create]

  def show
  end

  def index
    @products = Product.all
  end

  def edit
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params[:product])
    if @product.save
      redirect_to(@product, :notice => 'Product was successfully created.') 
    else
      render :action => "new" 
    end
  end

  def update
    if @product.update_attributes(params[:product])
      redirect_to(@product, :notice => 'Product was successfully updated.') 
    else
      render :action => "edit" 
    end
  end

  def destroy
    @product.destroy
    redirect_to(products_url) 
  end


  protected
  
  def load_product
    @product = Product.find(params[:id])
  end
end
