Rails.application.routes.draw do
  resources :services
  resources :departments
  get 'stocks/index'

  resources :roles
  resources :contacts
  resources :families
  get 'users/edit'

  get 'users/index'

  get 'users/new'

  get 'users/show'

  devise_for :users ,only: :session , path: 'session',path_name: {sign_in:'login',sign_out: 'logout'}
  get 'welcome/index'

  resources :purchases
  resources :providers
  resources :customers
  resources :sales
  resources :products
  resources :users
  resources :stocks

  root 'welcome#index'


  post  'sales/add_produit', to: 'sales#add_produit'
  post  'purchases/add_produit', to: 'purchases#add_produit'
  post  'sales/add_bonus', to: 'sales#add_bonus'


  get  'products/edit_price/:id', to: 'products#edit_price'


  get   'users/change_passd/:id', to: 'users#change_passd'

  get   'sales/:id/del_bonus', to: 'sales#del_bonus'

  get   'contacts/:id/del_role', to: 'contacts#del_role'



  post  'contacts/add_role', to: 'contacts#add_role'

  get   'sales/:id/delete_produit/:product_id' , to: 'sales#delete_produit'
  get   'purchases/:id/delete_produit/:product_id', to: 'purchases#delete_produit'

  get 'stock-alerts', to: 'stocks#alert_stock'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
