Before do
  DatabaseCleaner.start
  reset_mailer
end

After do |scenario|
  DatabaseCleaner.clean
end
