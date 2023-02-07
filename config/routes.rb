Rails.application.routes.draw do
  namespace :v1 do
    resources :blobs, only: :show do
      post '', on: :collection, action: :upsert, as: :upsert
    end
    # /resources :blobs
  end
end
