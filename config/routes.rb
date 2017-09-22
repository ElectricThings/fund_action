Rails.application.routes.draw do

  resources :user_invitations, controller: :invitations,
    only: %i(index new create destroy ) do

    member do
      patch :resend
    end
  end

  if Rails.env.development?
   mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  # re-route some devise endpoints that are unused
  get '/users/edit',    to: redirect('/')
  get '/users/sign_up', to: redirect('/')
  match '/users', to: redirect('/'), via: %i(put patch post delete)

  mount Decidim::Core::Engine => '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
