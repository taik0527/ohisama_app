# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'ohanashi@example.com'
  layout 'mailer'
end
