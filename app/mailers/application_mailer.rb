class ApplicationMailer < ActionMailer::Base
  # default from: 'from@example.com'
  default from: email_address_with_name("flashcards.info@gmail.com", "Flash Cards")
  layout 'mailer'
end
