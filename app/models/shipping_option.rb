class ShippingOption < ActiveRecord::Base

  belongs_to :deck

  validates :region_code, :value, presence: true

end
