require './lib/qreds/version'

Gem::Specification.new do |s|
  s.files = Dir['lib/**/*.rb']
  s.test_files = Dir['spec/**/*.rb']

  s.add_runtime_dependency 'activesupport'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'pry'

  s.name        = 'qreds'
  s.version     = Qreds::VERSION
  s.licenses    = 'MIT'
  s.date        = '2018-07-07'
  s.summary     = 'Query reducers.'
  s.description = 'Query reducers with built-in support for ActiveRecord & Grape, open for custom extensions.'
  s.homepage    = 'https://github.com/rafal42/qreds'
  s.email       = 'warzocha.rafal@gmail.com'
  s.authors     = 'Rafał Warzocha'
end
