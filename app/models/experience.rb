class Experience < ActiveRecord::Base
  belongs_to :user
  belongs_to :university

	before_save do
	self.experience.downcase!
	end
end
