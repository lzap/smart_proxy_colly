require 'socket'

module Proxy::Colly
  class Plugin < ::Proxy::Plugin
    plugin 'colly', Proxy::Colly::VERSION
    default_settings :socket => '/var/run/collectd-unixsock', :debug_socket => false, :timeout => 5

    http_rackup_path File.expand_path('middleware.ru', File.expand_path('../', __FILE__))
    https_rackup_path File.expand_path('middleware.ru', File.expand_path('../', __FILE__))

    # TODO this must be called after all are activated
    after_activation do
      writer = Proxy::Colly::Writer.new(Proxy::Colly::Plugin.settings.socket, Socket.gethostname, Proxy::Colly::Plugin.settings.timeout, Proxy::Colly::Plugin.settings.debug_socket)
      writer.notify "Proxy started, enabled plugins: " + ::Proxy::Plugins.enabled_plugins.map(&:plugin_name).join(' ')
      runner = Proxy::Colly::Runner.new(writer, Proxy::Colly::Plugin.settings.timeout)
      runner.start
    end

    # TODO add plugin deactivation into the API
    #after_deactivation {runner.stop}
  end
end
