class CardFactory

  CARD_WITH_COUNT_REGEX = /^([0-9]+(x)\s+).+$/

  def initialize(cards)
    @cards = initialize_cards(cards)
  end

  def perform!
    @cards.each do |card_name, card|
      card[:request] = api.queue(card_name)
    end
    api.run
    parse_responses
  end

  private

  def api
    @api ||= Api::MtgDb.new
  end

  def initialize_cards(cards)
    cards_with_count = Array(cards).collect do |card|
      next if card.empty?
      count, name = parse_card(card)
      [name, { name: name, times: count }]
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

  def parse_responses
    # responses.map { |name, response| parse_response(response, name) }
    @cards.map { |card_name, card| parse_response(card) }
  end

  def parse_response(card)
    response = card[:request].response
    cards = JSON.parse(response.body)
    if response.code == 200 && cards.any?
      to_hash(cards.first, card)
    else
      { name: card[:name], times: card[:times] }
    end
  end

  def to_hash(card_data, card)
    return unless card_data
    {
      name: card_data["name"],
      colors: card_data["colors"],
      multiverse_id: card_data["id"],
      times: card[:times],
      data: card_data
    }
  end
end
