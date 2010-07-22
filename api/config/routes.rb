ActionController::Routing::Routes.draw do |map|
  map.resources :products
  map.resources :pretty_products do |pretty_products|
    pretty_products.resources :comments
  end
  map.root :controller => "products", :action => "index"

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
