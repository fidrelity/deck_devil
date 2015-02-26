class CardFactory

  CARD_WITH_COUNT_REGEX = /^([0-9]+(x)\s+).+$/

  def initialize(cards)
    @cards = initialize_cards(cards)
  end

  def perform!
    @cards.each do |card_name, _|
      api.queue(card_name)
    end
    api.run
    parse_responses(api.responses)
  end

  private

  def api
    @api ||= Api::MtgDb.new
  end

  def initialize_cards(cards)
    cards_with_count = Array(cards).collect do |card|
      next if card.empty?
      count, name = parse_card(card)
      [name, { name: name, count: count }]
    end
    Hash[cards_with_count]
  end

  def parse_card(card)
    if card =~ CARD_WITH_COUNT_REGEX
      card.split("x ", 2)
    else
      [1, card]
    end
  end

  def parse_responses(responses)
    responses.map { |name, response| parse_response(response, name) }
  end

  def parse_response(response, name)
    cards = JSON.parse(response.body)
    if response.code == 200 && cards.any?
      to_hash(cards.first)
    else
      { name: name }
    end
  end

  def to_hash(card)
    return unless card
    {
      name: card["name"],
      colors: card["colors"],
      multiverse_id: card["id"],
      data: card
    }
  end
end
