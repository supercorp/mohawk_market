module UserMailerBrand
  ######## MakersMarket #########

  #COMMON#
  SETUP_EMAIL_SUBJECT = ""
  FOOTER = ''

  #ACCOUNT EMAILS#
  PLEASE_ACTIVATE = 'Please activate your new account'
  SIGNUP_NOTE = "After your account is activated we'll send you right along to the application."
  ACCOUNT_ACTIVATED = 'Your account has been activated!'
  PASSWORD_RESET = "Password Reset"

  #ORDER EMAILS#
  def order_cancelled(order)
    "order No. #{order.id} has been cancelled"
  end
  def order_shipped(order)
    "order No. #{order.id} has shipped!"
  end
  def order_number_subject(order)
    "order No. #{order.id}"
  end
  def pending_echeck_subject(order)
    "pending eCheck (order No. #{order.id})"
  end
  def cleared_echeck_subject(order)
    "cleared eCheck (order No. #{order.id})"
  end
  def failed_echeck_subject(order)
    "failed eCheck (order No. #{order.id})"
  end
  def option_restock_subject(product_option)
    "product option restock notice (#{product_option.product.name})"
  end
  
  #buyer_order_notification
  
end