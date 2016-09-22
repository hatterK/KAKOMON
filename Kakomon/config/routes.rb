Rails.application.routes.draw do
  root 'past_questions#index'

  resources :past_questions, only: [:index, :show] do
    collection { get 'search' }
    resources :tags, only: [] do
      collection { post 'set_tag' }
    end
  end

  resources :tags, only: [:index, :show]

  resources :members, only: [:index]

  resource :session, only: [:create, :destroy]

  namespace :editor do
    root to: "past_questions#index"
    resources :past_questions, exept: :destroy do
      collection { get 'search' }
      resources :tags, only: [] do
        collection { post 'set_tag' }
        member { get 'untag' }
      end
    end
    resources :tags, only: [:index, :show]
  end

  namespace :admin do
    root to: "past_questions#index"
    resources :past_questions do
      collection { get 'search' }
      resources :tags, only: [] do
        collection { post 'set_tag' }
        member { get 'untag' }
      end
    end
    resources :exam_dates do
      collection { get 'search' }
    end
    resources :tags, only: [:index, :show]
    resources :members
  end

  get 'bad_request' => 'error#bad_request'
  get 'internal_server_error' => 'error#internal_server_error'
  match "*anything" => 'error#not_found', via: [:get, :post, :patch, :delete]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
