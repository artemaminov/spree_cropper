Spree::Core::Engine.add_routes do
  namespace :admin do
    resource :cropper_settings, only: [:edit, :update]
  end
end
