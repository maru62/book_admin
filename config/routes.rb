Rails.application.routes.draw do

=begin profiles関係を削除
  get 'profiles/show'
  get 'profiles/edit'
  get 'profiles/update'
=end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  ## URLから（URLを）paramsに渡している
  # config/routes.rbにshowアクションのルーティングを追加する
  get "/books/:id" => "books#show"

  # destroyフック
  delete "/books/:id" => "books#destroy"

  resources :publishers
  resource :profile, only: %i{show edit update}

=begin 検証済み
　# resourcesのブロックでの拡張の例
  ## routesをネストするのはschedulebookのほうでやってみたかったな
  resources :publishers do
    resources :books
    member do
      get 'detail'
    end
    collection do
      get 'search'
    end
  end
=end

end
