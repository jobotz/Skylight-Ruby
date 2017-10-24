require 'skylight/core/railtie'

module Skylight
  class Railtie < Rails::Railtie
    include Skylight::Core::Railtie

    def self.config_class; Skylight::Config end

    config.skylight = ActiveSupport::OrderedOptions.new

    # The environments in which skylight should be enabled
    config.skylight.environments = ['production']

    # The path to the configuration file
    config.skylight.config_path = "config/skylight.yml"

    # The probes to load
    #   net_http, action_controller, action_view, middleware, and grape are on by default
    #   See https://www.skylight.io/support/getting-more-from-skylight#available-instrumentation-options
    #   for a full list.
    config.skylight.probes = ['net_http', 'action_controller', 'action_view', 'middleware', 'grape']

    # The position in the middleware stack to place Skylight
    # Default is first, but can be `{ after: Middleware::Name }` or `{ before: Middleware::Name }`
    config.skylight.middleware_position = 0

    initializer 'skylight.configure' do |app|
      run_initializer(app)
    end

    private

      def development_warning
        super + "\n(To disable this message for all local apps, run `skylight disable_dev_warning`.)"
      end

  end
end
