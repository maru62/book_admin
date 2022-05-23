Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  ## URLから（URLを）paramsに渡している
  # config/routes.rbにshowアクションのルーティングを追加する
  get "/books/:id" => "books#show"

  # destroyフック
  delete "/books/:id" => "books#destroy"

  # resourcesでいろいろついてくる
  # resources :publishers
  # resourcesのブロックでの拡張の例
  resources :publishers do
    resources :books
    member do
      get 'detail'
    end
    collection do
      get 'search'
    end
  end

end
