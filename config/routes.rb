Spree::Core::Engine.add_routes do
  namespace :admin do
    resources :cropper_dimensions
  end
end
