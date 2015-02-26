class DecksController < ApplicationController

  def new
    @deck = Deck.new
    @deck.cards.build
  end

  def create
    @deck = Deck.new(deck_params)
    @deck.cards.build(deck_cards_params)
    if @deck.save
      redirect_to deck_path(@deck)
    else
      @cards_list = params[:deck][:cards]
      render :new
    end
  end

  def index
    @decks = Deck.all
  end

  def show
    @deck = Deck.find(params[:id])
  end

  private

  def deck_params
    params.require(:deck).permit(:name, :price, :cards_attributes)
  end

  def deck_cards_params
    card_names = params[:deck][:cards].split("\r\n")
    CardFactory.new(card_names).perform!
  end
end

def test(reg)
  p "4x Howling Banshee".match(reg)
  p "4 Howling Banshee".match(reg)
  p "4x   Howling Banshee".match(reg)
end


def anti_test(reg)
p "panzer x4".match(reg)
p "4 panzer".match(reg)
p "3xajani".match(reg)
end
