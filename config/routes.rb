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

  mount Decidim::Core::Engine => '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
