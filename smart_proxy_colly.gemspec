require File.expand_path('../lib/smart_proxy_colly/version', __FILE__)

Gem::Specification.new do |s|
  s.name = 'smart_proxy_colly'
  s.version = Proxy::Colly::VERSION

  s.summary = 'Smart Proxy Colly plugin'
  s.description = 'Collectd monotiring through UNIX socket IPC'
  s.authors = ['Lukas Zapletal']
  s.email = 'lukas-x@zapletalovi.com'
  s.extra_rdoc_files = ['README.md', 'LICENSE']
  s.files = Dir['{lib,settings.d,bundler.d}/**/*'] + s.extra_rdoc_files
  s.homepage = 'http://github.com/lzap/smart_proxy_colly'
  s.license = 'GPLv3'

  s.add_dependency('collectd-uxsock')
  s.add_development_dependency('rake')
  s.add_development_dependency('rack')
end
