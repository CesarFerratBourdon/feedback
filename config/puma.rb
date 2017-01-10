#!/usr/bin/env puma

threads 16, 16

workers 2
worker_timeout 60

rackup      DefaultRackup
bind        "tcp://0.0.0.0:#{ENV.fetch('PORT', 3000)}"
environment ENV['RACK_ENV'] || 'development'

preload_app!

on_worker_boot do
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
  end
end

after_worker_boot do
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
  end
end