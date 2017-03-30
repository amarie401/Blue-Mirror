ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'capybara-screenshot/minitest'

class ActionDispatch::IntegrationTest
  include Capybara::DSL
  Capybara.current_driver = :selenium
  Capybara.app_host = 'http://localhost:3000'
  Capybara.server_host = 'localhost'
  Capybara.server_port = '3000'

  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, browser: :chrome)
  end
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
