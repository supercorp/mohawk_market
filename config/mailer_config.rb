ActionMailer::Base.smtp_settings = {
  :address  => "smtp.gmail.com",
  :port => 587,
  :user_name => 'mohawk.cc.dev@wearesupercorp.com',
  :password => '233N0rm4n',
  :authentication => :plain
}
ActionMailer::Base::ORDER_FROM_ADDR = 'mohawk.cc.staging@wearesupercorp.com'
ActionMailer::Base::ALERTS_FROM_ADDR = 'mohawk.cc.staging@wearesupercorp.com'
ActionMailer::Base::BILLING_FROM_ADDR = 'mohawk.cc.staging@wearesupercorp.com'
ActionMailer::Base::MESSAGE_FROM_ADDR = 'mohawk.cc.staging@wearesupercorp.com'
ActionMailer::Base::WEB_SITE_URL = 'http://localhost:3000'
ActionMailer::Base::FROM_ADDR = 'mohawk.cc.dev@wearesupercorp.com'
ActionMailer::Base::SETUP_EMAIL_SUBJECT = "Sample CC dev site new account"
