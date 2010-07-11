class PrettyProductsController < ApplicationController
  def index
    @products = Product.all
    respond_to do |format|
      format.json { render_success(@products) }
      format.html
    end
  end

  def update
    @product = Product.find(params[:id])
    respond_to do |format|
      if @product.update_attributes(params[:data])
        format.json { render_success(@product) }
      else
        format.json { render_failure(@product) }
      end
    end
  end

  def create
    @product = Product.new(params[:data])
    respond_to do |format|
      if @product.save
        format.json { render_success(@product) }
      else
        format.json { render_failure(@product) }
      end
    end
  end
  
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    respond_to do |format|
      format.json { render_success(@product) }
    end
  end

  protected

  def render_success(product)
    render :json => { :data => product, :success => true, :message => "OK" }    
  end

  def render_failure(product)
    render :json => { :data => product, :success => false, :message => product.errors.full_messages.join(". ") }
  end
end
