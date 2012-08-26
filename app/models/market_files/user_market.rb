module UserMarket
	def add_subscriber
		begin
			client = Pardot::Client.new 'ryan@wearesupercorp.com', 'M0hawk123', 'ee83b9cc736657c1f6fde3c51ebb5d32'
			prospect = client.prospects.create(self.email, :list_65071 => 1)
		rescue
		end
	end
end