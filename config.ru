# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

Schachclub::Application.config.middleware.use ExceptionNotifier,
                      :email => {
                          email_prefix: '[Whatever] ',
                          sender_address: '"notifier" <notifier@tusffb-schach.de>',
                          exception_recipients: %w{bernd.m.walter@gmail.com}
                      }

run Schachclub::Application
