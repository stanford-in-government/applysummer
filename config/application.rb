require File.expand_path('../boot', __FILE__)

require 'csv'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Fellowship
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'America/Los_Angeles'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.fellowship = ActiveSupport::OrderedOptions.new

    # Maximum number of fellowships the applicant is allowed to rank
    config.fellowship.num_selected = 8

    # Maximum number of fellowships the applicant is allowed to submit a detailed response for
    config.fellowship.num_applied = 3

    # Only allow one type of active application at a time
    config.fellowship.restrict_single_application = false

    # Set all the deadlines
    config.fellowship.deadlines = {
      stipend: {
        first: DateTime.parse('Feburary 14, 2015 at 11:59pm -8:00'),
        second: DateTime.parse('April 6, 2015 at 11:59pm -8:00'),
      },
      fellowship: {
        application: DateTime.parse('Feburary 6, 2015 at 11:59pm -8:00'),
        recommendation: DateTime.parse('Feburary 10, 2015 at 11:59pm -8:00'),
      },
    }
  end
end
