Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  if !Docuseal.multitenant? && defined?(Sidekiq::Web)
    authenticated :user, ->(u) { u.sidekiq? } do
      mount Sidekiq::Web => '/jobs'
    end
  end

  root 'dashboard#index'

  get 'up' => 'rails/health#show'
  get 'manifest' => 'pwa#manifest'

  # ✅ تسجيل دخول + تسجيل جديد
  devise_for :users,
             path: '/',
             only: %i[sessions registrations passwords omniauth_callbacks],
             controllers: begin
               options = {
                 sessions: 'sessions',
                 registrations: 'users/registrations',
                 passwords: 'passwords'
               }
               options[:omniauth_callbacks] = 'omniauth_callbacks' if User.devise_modules.include?(:omniauthable)
               options
             end

  # ✅ تسجيل حساب عام
  devise_scope :user do
    get '/signup', to: 'users/registrations#new', as: :new_user_registration_public
    post '/signup', to: 'users/registrations#create', as: :user_registration_public
    resource :invitation, only: %i[update] do
      get '' => :edit
    end
  end

  # باقي الروترات تبقى كما هي
  namespace :api, defaults: { format: :json } do
    resource :user, only: %i[show]
    resources :attachments, only: %i[create]
    resources :submitter_email_clicks, only: %i[create]
    resources :submitter_form_views, only: %i[create]
    resources :submitters, only: %i[index show update]
    resources :submissions, only: %i[index show create destroy] do
      resources :documents, only: %i[index], controller: 'submission_documents'
      collection do
        resources :init, only: %i[create], controller: 'submissions'
        resources :emails, only: %i[create], controller: 'submissions', as: :submissions_emails
      end
    end
    resources :templates, only: %i[update show index destroy] do
      resources :clone, only: %i[create], controller: 'templates_clone'
      resources :submissions, only: %i[index create]
    end
    resources :tools, only: %i[] do
      post :merge, on: :collection
      post :verify, on: :collection
    end
    scope 'events' do
      resources :form_events, only: %i[index], path: 'form/:type'
      resources :submission_events, only: %i[index], path: 'submission/:type'
    end
  end

  # … جميع الروترات الباقية تبقى بدون تغيير …
  # لتفادي إرسال ملف ضخم جداً هنا، إذا كنت ترغب أن أرسل كل الكود الكامل بعد هذا الجزء أيضاً، فقط اكتب:
  # أرسل باقي routes.rb

  get '/js/:filename', to: 'embed_scripts#show', as: :embed_script
  ActiveSupport.run_load_hooks(:routes, self)
end
