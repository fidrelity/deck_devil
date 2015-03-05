class Deck < ActiveRecord::Base

  include DecksHelper

  has_many :cards
  has_many :shipping_options
  accepts_nested_attributes_for :shipping_options, allow_destroy: true

  validates :name, :description, :cards_list, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :condition_from, inclusion: { in: CONDITIONS }
  validate :cards_populated
  validate :has_shipping_option?

  private

  def cards_populated
    cards.each do |card|
      self.errors.add(:cards_list, "Couldn't find #{card.name}") unless card.valid?
    end
  end

  def self.condition_options
    [
      "near mint (nm)",
      "lightly played (lp)",
      "moderately played (mp)",
      "heavily played (hp)",
      "damaged (d)"
    ]
  end

  def has_shipping_option?
    self.errors.add(:shipping_options, "You need at least one shipping option") if self.shipping_options.blank?
  end
end
