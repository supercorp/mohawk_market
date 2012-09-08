module SellerMarket
  BANNER_THUMBNAIL_SIZES = { :full_width => "866x100>"}
  BANNER_SIZE_HELP_TEXT = "the optimal size is 866 x 100 px"
  FEATURED_PRODUCT_ROW_LIMIT = 3
  FEATURED_PRODUCT_LIMIT = FEATURED_PRODUCT_ROW_LIMIT * (MARKET_UNITS_PER_ROW - 1)

  def add_to_campaign_monitor_seller_list
    Rails.logger.info("Seller#add_to_campaign_monitor_seller_list: adding #{email}")
    begin
      client = Pardot::Client.new 'ryan@wearesupercorp.com', 'M0hawk123', 'ee83b9cc736657c1f6fde3c51ebb5d32'
      prospect = client.prospects.update_by_email(email, :list_66391 => 1)
    rescue Exception => e
      Rails.logger.error("Seller#add_to_campaign_monitor_seller_list: error adding #{email}")
      Rails.logger.error(e.message)
      Rails.logger.error(e.backtrace.join("\n"))
    end
	end
end