require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Paibei
  PRIVINCES = [[0, '上海'], [1, '北京'], [2, '天津'], [3, '重庆'],
            [4, '安徽'], [5, '福建'], [6, '甘肃'], [7, '广东'],
            [8, '贵州'], [9, '河北'], [10, '黑龙江'], [11, '河南'],
            [12, '湖北'], [13, '湖南'], [14, '吉林'], [15, '江西'],
            [16, '江苏'], [17, '辽宁'], [18, '山东'], [19, '陕西'],
            [20, '山西'], [21, '四川'], [22, '云南'], [23, '浙江'],
            [24, '青海'], [25, '海南'], [26, '台湾'], [27, '广西'],
            [28, '内蒙古'], [29, '宁夏'], [30, '西藏'], [31, '新疆' ],
            [32, '测试']]

  USER = {email: 'admin@paibei.com', password: 'paibei'}


  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.time_zone = 'Beijing'
    config.active_record.default_timezone = :local
  end
end
