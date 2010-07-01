ActionController::Routing::Routes.draw do |map|
  map.resources :products

  map.resources :categories
  map.resources :products
  
  map.root :controller => "categories", :action => "index"
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
