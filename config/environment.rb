# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

module EveHug
  class Application < Rails::Application
    # config.force_ssl = false
    config.time_zone = 'Asia/Seoul'
  end
end