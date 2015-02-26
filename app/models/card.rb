class Card < ActiveRecord::Base

  IMAGE_BASE_URL = "http://api.mtgdb.info/content/card_images/"

  belongs_to :deck
  validates :name, :multiverse_id, presence: true

  def image_url
     IMAGE_BASE_URL + multiverse_id.to_s + ".jpeg"
  end
end
