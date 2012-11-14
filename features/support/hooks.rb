Before do
  reset_mailer
end


After do
  DatabaseCleaner.clean
end
