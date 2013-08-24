Myrottenpotatoes::Application.routes.draw do
  resources :movies
  root :to => redirect('/movies')
  get  'auth/:provider/callback' => 'sessions#create',:as => 'login'
  post 'logout' => 'sessions#destroy'
  get  'auth/failure' => 'sessions#failure'
end
