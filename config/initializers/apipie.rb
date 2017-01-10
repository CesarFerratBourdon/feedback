Apipie.configure do |config|
  config.app_name                = 'Feedbk'
  config.api_base_url            = ''
  config.doc_base_url            = '/docs'
  config.app_info                = 'Feedbk JSON API'
  config.validate                = false
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
end
