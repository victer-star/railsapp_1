require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Myapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

      config.generators do |g|
        g.assets false          # CSS, JavaScriptファイルは生成しない
        g.test_framework false  # testファイルは生成しない
      end

      g.test_framework :rspec,
          controller_specs: false,
          view_specs: false,
          helper_specs: false,
          routing_specs: false
      end
  end
end
