module DecksHelper

  CONDITIONS = %w(nm lp mp hp d)

  def condition_options
    [
      "Near mint (NM)",
      "Lightly played (LP)",
      "Moderately played (MP)",
      "Heavily played (HP)",
      "Damaged (D)"
    ].zip(CONDITIONS)
  end

  def shipping_location_options
    grouped_options = [
      ['Regions', [
        ["Worldwide", "all"],
        ["Europe", "eu"],
        ["United States", "us"]
      ]],
      ['Country List', Country.all]
    ]
    grouped_options_for_select(grouped_options)
  end
end
