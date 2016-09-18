class ApplicationMailer < ActionMailer::Base
  default from: %("House Chores" <#{Rails.configuration.from_email}>)
  layout 'mailer'
end
