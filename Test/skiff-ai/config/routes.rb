Rails.application.routes.draw do
  scope :api do
    get "up" => "rails/health#show", as: :rails_health_check

    resources :dialogues, only: :create

    resources :tokens, only: :create

    resources :chats

    resources :messages, only: [:create, :index]
  end
end
