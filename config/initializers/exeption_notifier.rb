Rails.application.config.middleware.use ExceptionNotifier,
                                        :email_prefix => '[TuS Schach Fehler] ',
                                        :sender_address => %{"exception notifier" <notifier@tusffb-schach.de>},
                                        :exception_recipients => %w{bernd.m.walter@gmail.com}