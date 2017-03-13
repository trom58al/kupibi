require 'rspec'
require 'rack/test'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods

  conf.mock_with :rspec do |mocks|
    mocks.syntax = :should
  end
end
