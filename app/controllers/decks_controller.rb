class DecksController < ApplicationController

  def new
    @deck = Deck.new
    @deck.shipping_options.build
  end

  def create
    @deck = Deck.new(deck_params)
    @deck.cards.build(deck_cards_params)
    if @deck.save
      redirect_to deck_path(@deck)
    else
      @cards_list = params[:deck][:cards_list]
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
    params.require(:deck).permit(
      :name, :price, :condition_from, :condition_to, :cards_list, :description,
      shipping_options_attributes: [:region_code, :value]
    )
  end

  def deck_cards_params
    card_names = params[:deck][:cards_list].split("\r\n")
    CardFactory.new(card_names).perform!
  end
end
