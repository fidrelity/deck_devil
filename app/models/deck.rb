class Deck < ActiveRecord::Base

  has_many :cards
  accepts_nested_attributes_for :cards, allow_destroy: true

  validates :name, presence: true
  validates :price, numericality: { greater_than: 0 }
  validate :cards_populated

  private

  def cards_populated
    cards.each do |card|
      self.errors.add(:cards, "Couldn't find #{card.name}") unless card.valid?
    end
  end
end
