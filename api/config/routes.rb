ActionController::Routing::Routes.draw do |map|
  map.resources :products
  map.resources :pretty_products  
  map.root :controller => "products", :action => "index"

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
