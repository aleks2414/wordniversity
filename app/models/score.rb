class Score < ActiveRecord::Base
  belongs_to :user
  belongs_to :university
  validates_numericality_of :star, :less_than_or_equal_to => 5
end
