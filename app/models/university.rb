class University < ActiveRecord::Base
	belongs_to :user

extend FriendlyId
  friendly_id :name, use: :slugged

	geocoded_by :full_address
	after_validation :geocode, if: :name_changed?

	def full_address
		"#{name},#{country_code}"
	end

	reverse_geocoded_by :latitude, :longitude,
	:address => :address
	before_save :reverse_geocode, if: :name_changed?


	validates :url, presence: true, :format => URI::regexp(%w(http https))

	before_save :scrape_with_grabbit

	

	private

	def scrape_with_grabbit

		# I highly recommend passing the following call off to a Resque worker, or Delayed Job queue.
		# The reason is that Grabbit will attempt to access the remote URL. If there is a network problem,
		# or the remote URL is unavailable, the following line could hang up your Rails process.
		
		data = Grabbit.url(url)
		
		if data
			self.description = data.description
			self.image = data.images.first
		end

	end
end
