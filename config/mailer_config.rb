ActionMailer::Base.smtp_settings = {
  :address  => "smtp.gmail.com",
  :port => 587,
  :user_name => 'do-not-reply@feltandwireshop.com',
  :password => 'feltandw1re',
  :authentication => :plain
}
ActionMailer::Base::ORDER_FROM_ADDR = 'orders@feltandwireshop.com'
ActionMailer::Base::ALERTS_FROM_ADDR = 'alerts@feltandwireshop.com'
ActionMailer::Base::BILLING_FROM_ADDR = 'billing@feltandwireshop.com'
ActionMailer::Base::MESSAGE_FROM_ADDR = 'messages@feltandwireshop.com'
ActionMailer::Base::FROM_ADDR = 'do-not-reply@feltandwireshop.com'
ActionMailer::Base::SETUP_EMAIL_SUBJECT = "[Felt and Wire Shop]"
