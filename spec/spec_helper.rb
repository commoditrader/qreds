require 'bundler/setup'
require 'qreds'

Bundler.require(:default, :test)

require_relative 'support/mock_collection'
require_relative 'support/mock_endpoint'
require_relative 'support/mock_model'
require_relative 'support/filters'
require_relative 'support/sort'
require_relative 'support/simple_object'
