Spree::Core::Engine.add_routes do
  namespace :admin do
    resources :cropper_devices
  end
end
