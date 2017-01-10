# -*- encoding: utf-8 -*-
# stub: devise 3.5.3 ruby lib

Gem::Specification.new do |s|
  s.name = "devise"
  s.version = "3.5.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Jos\u{e9} Valim", "Carlos Ant\u{f4}nio"]
  s.date = "2015-12-19"
  s.description = "Flexible authentication solution for Rails with Warden"
  s.email = "contact@plataformatec.com.br"
  s.files = [".gitignore", ".travis.yml", ".yardopts", "CHANGELOG.md", "CODE_OF_CONDUCT.md", "CONTRIBUTING.md", "Gemfile", "Gemfile.lock", "MIT-LICENSE", "README.md", "Rakefile", "app/controllers/devise/confirmations_controller.rb", "app/controllers/devise/omniauth_callbacks_controller.rb", "app/controllers/devise/passwords_controller.rb", "app/controllers/devise/registrations_controller.rb", "app/controllers/devise/sessions_controller.rb", "app/controllers/devise/unlocks_controller.rb", "app/controllers/devise_controller.rb", "app/helpers/devise_helper.rb", "app/mailers/devise/mailer.rb", "app/views/devise/confirmations/new.html.erb", "app/views/devise/mailer/confirmation_instructions.html.erb", "app/views/devise/mailer/password_change.html.erb", "app/views/devise/mailer/reset_password_instructions.html.erb", "app/views/devise/mailer/unlock_instructions.html.erb", "app/views/devise/passwords/edit.html.erb", "app/views/devise/passwords/new.html.erb", "app/views/devise/registrations/edit.html.erb", "app/views/devise/registrations/new.html.erb", "app/views/devise/sessions/new.html.erb", "app/views/devise/shared/_links.html.erb", "app/views/devise/unlocks/new.html.erb", "config/locales/en.yml", "devise.gemspec", "devise.png", "gemfiles/Gemfile.rails-4.1-stable", "gemfiles/Gemfile.rails-4.1-stable.lock", "gemfiles/Gemfile.rails-4.2-stable", "gemfiles/Gemfile.rails-4.2-stable.lock", "gemfiles/Gemfile.rails-5.0-alpha", "gemfiles/Gemfile.rails-5.0-alpha.lock", "lib/devise.rb", "lib/devise/controllers/helpers.rb", "lib/devise/controllers/rememberable.rb", "lib/devise/controllers/scoped_views.rb", "lib/devise/controllers/sign_in_out.rb", "lib/devise/controllers/store_location.rb", "lib/devise/controllers/url_helpers.rb", "lib/devise/delegator.rb", "lib/devise/encryptor.rb", "lib/devise/failure_app.rb", "lib/devise/hooks/activatable.rb", "lib/devise/hooks/csrf_cleaner.rb", "lib/devise/hooks/forgetable.rb", "lib/devise/hooks/lockable.rb", "lib/devise/hooks/proxy.rb", "lib/devise/hooks/rememberable.rb", "lib/devise/hooks/timeoutable.rb", "lib/devise/hooks/trackable.rb", "lib/devise/mailers/helpers.rb", "lib/devise/mapping.rb", "lib/devise/models.rb", "lib/devise/models/authenticatable.rb", "lib/devise/models/confirmable.rb", "lib/devise/models/database_authenticatable.rb", "lib/devise/models/lockable.rb", "lib/devise/models/omniauthable.rb", "lib/devise/models/recoverable.rb", "lib/devise/models/registerable.rb", "lib/devise/models/rememberable.rb", "lib/devise/models/timeoutable.rb", "lib/devise/models/trackable.rb", "lib/devise/models/validatable.rb", "lib/devise/modules.rb", "lib/devise/omniauth.rb", "lib/devise/omniauth/config.rb", "lib/devise/omniauth/url_helpers.rb", "lib/devise/orm/active_record.rb", "lib/devise/orm/mongoid.rb", "lib/devise/parameter_filter.rb", "lib/devise/parameter_sanitizer.rb", "lib/devise/rails.rb", "lib/devise/rails/routes.rb", "lib/devise/rails/warden_compat.rb", "lib/devise/strategies/authenticatable.rb", "lib/devise/strategies/base.rb", "lib/devise/strategies/database_authenticatable.rb", "lib/devise/strategies/rememberable.rb", "lib/devise/test_helpers.rb", "lib/devise/time_inflector.rb", "lib/devise/token_generator.rb", "lib/devise/version.rb", "lib/generators/active_record/devise_generator.rb", "lib/generators/active_record/templates/migration.rb", "lib/generators/active_record/templates/migration_existing.rb", "lib/generators/devise/controllers_generator.rb", "lib/generators/devise/devise_generator.rb", "lib/generators/devise/install_generator.rb", "lib/generators/devise/orm_helpers.rb", "lib/generators/devise/views_generator.rb", "lib/generators/mongoid/devise_generator.rb", "lib/generators/templates/README", "lib/generators/templates/controllers/README", "lib/generators/templates/controllers/confirmations_controller.rb", "lib/generators/templates/controllers/omniauth_callbacks_controller.rb", "lib/generators/templates/controllers/passwords_controller.rb", "lib/generators/templates/controllers/registrations_controller.rb", "lib/generators/templates/controllers/sessions_controller.rb", "lib/generators/templates/controllers/unlocks_controller.rb", "lib/generators/templates/devise.rb", "lib/generators/templates/markerb/confirmation_instructions.markerb", "lib/generators/templates/markerb/password_change.markerb", "lib/generators/templates/markerb/reset_password_instructions.markerb", "lib/generators/templates/markerb/unlock_instructions.markerb", "lib/generators/templates/simple_form_for/confirmations/new.html.erb", "lib/generators/templates/simple_form_for/passwords/edit.html.erb", "lib/generators/templates/simple_form_for/passwords/new.html.erb", "lib/generators/templates/simple_form_for/registrations/edit.html.erb", "lib/generators/templates/simple_form_for/registrations/new.html.erb", "lib/generators/templates/simple_form_for/sessions/new.html.erb", "lib/generators/templates/simple_form_for/unlocks/new.html.erb", "script/cached-bundle", "script/s3-put", "test/controllers/custom_registrations_controller_test.rb", "test/controllers/custom_strategy_test.rb", "test/controllers/helper_methods_test.rb", "test/controllers/helpers_test.rb", "test/controllers/inherited_controller_i18n_messages_test.rb", "test/controllers/internal_helpers_test.rb", "test/controllers/load_hooks_controller_test.rb", "test/controllers/passwords_controller_test.rb", "test/controllers/sessions_controller_test.rb", "test/controllers/url_helpers_test.rb", "test/delegator_test.rb", "test/devise_test.rb", "test/failure_app_test.rb", "test/generators/active_record_generator_test.rb", "test/generators/controllers_generator_test.rb", "test/generators/devise_generator_test.rb", "test/generators/install_generator_test.rb", "test/generators/mongoid_generator_test.rb", "test/generators/views_generator_test.rb", "test/helpers/devise_helper_test.rb", "test/integration/authenticatable_test.rb", "test/integration/confirmable_test.rb", "test/integration/database_authenticatable_test.rb", "test/integration/http_authenticatable_test.rb", "test/integration/lockable_test.rb", "test/integration/omniauthable_test.rb", "test/integration/recoverable_test.rb", "test/integration/registerable_test.rb", "test/integration/rememberable_test.rb", "test/integration/timeoutable_test.rb", "test/integration/trackable_test.rb", "test/mailers/confirmation_instructions_test.rb", "test/mailers/reset_password_instructions_test.rb", "test/mailers/unlock_instructions_test.rb", "test/mapping_test.rb", "test/models/authenticatable_test.rb", "test/models/confirmable_test.rb", "test/models/database_authenticatable_test.rb", "test/models/lockable_test.rb", "test/models/omniauthable_test.rb", "test/models/recoverable_test.rb", "test/models/registerable_test.rb", "test/models/rememberable_test.rb", "test/models/serializable_test.rb", "test/models/timeoutable_test.rb", "test/models/trackable_test.rb", "test/models/validatable_test.rb", "test/models_test.rb", "test/omniauth/config_test.rb", "test/omniauth/url_helpers_test.rb", "test/orm/active_record.rb", "test/orm/mongoid.rb", "test/parameter_sanitizer_test.rb", "test/rails_app/Rakefile", "test/rails_app/app/active_record/admin.rb", "test/rails_app/app/active_record/shim.rb", "test/rails_app/app/active_record/user.rb", "test/rails_app/app/active_record/user_on_engine.rb", "test/rails_app/app/active_record/user_on_main_app.rb", "test/rails_app/app/active_record/user_without_email.rb", "test/rails_app/app/controllers/admins/sessions_controller.rb", "test/rails_app/app/controllers/admins_controller.rb", "test/rails_app/app/controllers/application_controller.rb", "test/rails_app/app/controllers/application_with_fake_engine.rb", "test/rails_app/app/controllers/custom/registrations_controller.rb", "test/rails_app/app/controllers/home_controller.rb", "test/rails_app/app/controllers/publisher/registrations_controller.rb", "test/rails_app/app/controllers/publisher/sessions_controller.rb", "test/rails_app/app/controllers/users/omniauth_callbacks_controller.rb", "test/rails_app/app/controllers/users_controller.rb", "test/rails_app/app/helpers/application_helper.rb", "test/rails_app/app/mailers/users/from_proc_mailer.rb", "test/rails_app/app/mailers/users/mailer.rb", "test/rails_app/app/mailers/users/reply_to_mailer.rb", "test/rails_app/app/mongoid/admin.rb", "test/rails_app/app/mongoid/shim.rb", "test/rails_app/app/mongoid/user.rb", "test/rails_app/app/mongoid/user_on_engine.rb", "test/rails_app/app/mongoid/user_on_main_app.rb", "test/rails_app/app/mongoid/user_without_email.rb", "test/rails_app/app/views/admins/index.html.erb", "test/rails_app/app/views/admins/sessions/new.html.erb", "test/rails_app/app/views/home/admin_dashboard.html.erb", "test/rails_app/app/views/home/index.html.erb", "test/rails_app/app/views/home/join.html.erb", "test/rails_app/app/views/home/private.html.erb", "test/rails_app/app/views/home/user_dashboard.html.erb", "test/rails_app/app/views/layouts/application.html.erb", "test/rails_app/app/views/users/edit_form.html.erb", "test/rails_app/app/views/users/index.html.erb", "test/rails_app/app/views/users/mailer/confirmation_instructions.erb", "test/rails_app/app/views/users/sessions/new.html.erb", "test/rails_app/bin/bundle", "test/rails_app/bin/rails", "test/rails_app/bin/rake", "test/rails_app/config.ru", "test/rails_app/config/application.rb", "test/rails_app/config/boot.rb", "test/rails_app/config/database.yml", "test/rails_app/config/environment.rb", "test/rails_app/config/environments/development.rb", "test/rails_app/config/environments/production.rb", "test/rails_app/config/environments/test.rb", "test/rails_app/config/initializers/backtrace_silencers.rb", "test/rails_app/config/initializers/devise.rb", "test/rails_app/config/initializers/inflections.rb", "test/rails_app/config/initializers/secret_token.rb", "test/rails_app/config/initializers/session_store.rb", "test/rails_app/config/routes.rb", "test/rails_app/db/migrate/20100401102949_create_tables.rb", "test/rails_app/db/schema.rb", "test/rails_app/lib/shared_admin.rb", "test/rails_app/lib/shared_user.rb", "test/rails_app/lib/shared_user_without_email.rb", "test/rails_app/lib/shared_user_without_omniauth.rb", "test/rails_app/public/404.html", "test/rails_app/public/422.html", "test/rails_app/public/500.html", "test/rails_app/public/favicon.ico", "test/rails_test.rb", "test/routes_test.rb", "test/support/action_controller/record_identifier.rb", "test/support/assertions.rb", "test/support/helpers.rb", "test/support/http_method_compatibility.rb", "test/support/integration.rb", "test/support/locale/en.yml", "test/support/mongoid.yml", "test/support/webrat/integrations/rails.rb", "test/test_helper.rb", "test/test_helpers_test.rb", "test/test_models.rb"]
  s.homepage = "https://github.com/plataformatec/devise"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.1.0")
  s.rubygems_version = "2.4.5.1"
  s.summary = "Flexible authentication solution for Rails with Warden"
  s.test_files = ["test/controllers/custom_registrations_controller_test.rb", "test/controllers/custom_strategy_test.rb", "test/controllers/helper_methods_test.rb", "test/controllers/helpers_test.rb", "test/controllers/inherited_controller_i18n_messages_test.rb", "test/controllers/internal_helpers_test.rb", "test/controllers/load_hooks_controller_test.rb", "test/controllers/passwords_controller_test.rb", "test/controllers/sessions_controller_test.rb", "test/controllers/url_helpers_test.rb", "test/delegator_test.rb", "test/devise_test.rb", "test/failure_app_test.rb", "test/generators/active_record_generator_test.rb", "test/generators/controllers_generator_test.rb", "test/generators/devise_generator_test.rb", "test/generators/install_generator_test.rb", "test/generators/mongoid_generator_test.rb", "test/generators/views_generator_test.rb", "test/helpers/devise_helper_test.rb", "test/integration/authenticatable_test.rb", "test/integration/confirmable_test.rb", "test/integration/database_authenticatable_test.rb", "test/integration/http_authenticatable_test.rb", "test/integration/lockable_test.rb", "test/integration/omniauthable_test.rb", "test/integration/recoverable_test.rb", "test/integration/registerable_test.rb", "test/integration/rememberable_test.rb", "test/integration/timeoutable_test.rb", "test/integration/trackable_test.rb", "test/mailers/confirmation_instructions_test.rb", "test/mailers/reset_password_instructions_test.rb", "test/mailers/unlock_instructions_test.rb", "test/mapping_test.rb", "test/models/authenticatable_test.rb", "test/models/confirmable_test.rb", "test/models/database_authenticatable_test.rb", "test/models/lockable_test.rb", "test/models/omniauthable_test.rb", "test/models/recoverable_test.rb", "test/models/registerable_test.rb", "test/models/rememberable_test.rb", "test/models/serializable_test.rb", "test/models/timeoutable_test.rb", "test/models/trackable_test.rb", "test/models/validatable_test.rb", "test/models_test.rb", "test/omniauth/config_test.rb", "test/omniauth/url_helpers_test.rb", "test/orm/active_record.rb", "test/orm/mongoid.rb", "test/parameter_sanitizer_test.rb", "test/rails_app/Rakefile", "test/rails_app/app/active_record/admin.rb", "test/rails_app/app/active_record/shim.rb", "test/rails_app/app/active_record/user.rb", "test/rails_app/app/active_record/user_on_engine.rb", "test/rails_app/app/active_record/user_on_main_app.rb", "test/rails_app/app/active_record/user_without_email.rb", "test/rails_app/app/controllers/admins/sessions_controller.rb", "test/rails_app/app/controllers/admins_controller.rb", "test/rails_app/app/controllers/application_controller.rb", "test/rails_app/app/controllers/application_with_fake_engine.rb", "test/rails_app/app/controllers/custom/registrations_controller.rb", "test/rails_app/app/controllers/home_controller.rb", "test/rails_app/app/controllers/publisher/registrations_controller.rb", "test/rails_app/app/controllers/publisher/sessions_controller.rb", "test/rails_app/app/controllers/users/omniauth_callbacks_controller.rb", "test/rails_app/app/controllers/users_controller.rb", "test/rails_app/app/helpers/application_helper.rb", "test/rails_app/app/mailers/users/from_proc_mailer.rb", "test/rails_app/app/mailers/users/mailer.rb", "test/rails_app/app/mailers/users/reply_to_mailer.rb", "test/rails_app/app/mongoid/admin.rb", "test/rails_app/app/mongoid/shim.rb", "test/rails_app/app/mongoid/user.rb", "test/rails_app/app/mongoid/user_on_engine.rb", "test/rails_app/app/mongoid/user_on_main_app.rb", "test/rails_app/app/mongoid/user_without_email.rb", "test/rails_app/app/views/admins/index.html.erb", "test/rails_app/app/views/admins/sessions/new.html.erb", "test/rails_app/app/views/home/admin_dashboard.html.erb", "test/rails_app/app/views/home/index.html.erb", "test/rails_app/app/views/home/join.html.erb", "test/rails_app/app/views/home/private.html.erb", "test/rails_app/app/views/home/user_dashboard.html.erb", "test/rails_app/app/views/layouts/application.html.erb", "test/rails_app/app/views/users/edit_form.html.erb", "test/rails_app/app/views/users/index.html.erb", "test/rails_app/app/views/users/mailer/confirmation_instructions.erb", "test/rails_app/app/views/users/sessions/new.html.erb", "test/rails_app/bin/bundle", "test/rails_app/bin/rails", "test/rails_app/bin/rake", "test/rails_app/config.ru", "test/rails_app/config/application.rb", "test/rails_app/config/boot.rb", "test/rails_app/config/database.yml", "test/rails_app/config/environment.rb", "test/rails_app/config/environments/development.rb", "test/rails_app/config/environments/production.rb", "test/rails_app/config/environments/test.rb", "test/rails_app/config/initializers/backtrace_silencers.rb", "test/rails_app/config/initializers/devise.rb", "test/rails_app/config/initializers/inflections.rb", "test/rails_app/config/initializers/secret_token.rb", "test/rails_app/config/initializers/session_store.rb", "test/rails_app/config/routes.rb", "test/rails_app/db/migrate/20100401102949_create_tables.rb", "test/rails_app/db/schema.rb", "test/rails_app/lib/shared_admin.rb", "test/rails_app/lib/shared_user.rb", "test/rails_app/lib/shared_user_without_email.rb", "test/rails_app/lib/shared_user_without_omniauth.rb", "test/rails_app/public/404.html", "test/rails_app/public/422.html", "test/rails_app/public/500.html", "test/rails_app/public/favicon.ico", "test/rails_test.rb", "test/routes_test.rb", "test/support/action_controller/record_identifier.rb", "test/support/assertions.rb", "test/support/helpers.rb", "test/support/http_method_compatibility.rb", "test/support/integration.rb", "test/support/locale/en.yml", "test/support/mongoid.yml", "test/support/webrat/integrations/rails.rb", "test/test_helper.rb", "test/test_helpers_test.rb", "test/test_models.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<warden>, ["~> 1.2.3"])
      s.add_runtime_dependency(%q<orm_adapter>, ["~> 0.1"])
      s.add_runtime_dependency(%q<bcrypt>, ["~> 3.0"])
      s.add_runtime_dependency(%q<railties>, ["< 5.1", ">= 4.1.0"])
      s.add_runtime_dependency(%q<responders>, [">= 0"])
    else
      s.add_dependency(%q<warden>, ["~> 1.2.3"])
      s.add_dependency(%q<orm_adapter>, ["~> 0.1"])
      s.add_dependency(%q<bcrypt>, ["~> 3.0"])
      s.add_dependency(%q<railties>, ["< 5.1", ">= 4.1.0"])
      s.add_dependency(%q<responders>, [">= 0"])
    end
  else
    s.add_dependency(%q<warden>, ["~> 1.2.3"])
    s.add_dependency(%q<orm_adapter>, ["~> 0.1"])
    s.add_dependency(%q<bcrypt>, ["~> 3.0"])
    s.add_dependency(%q<railties>, ["< 5.1", ">= 4.1.0"])
    s.add_dependency(%q<responders>, [">= 0"])
  end
end
