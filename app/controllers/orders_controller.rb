class OrdersController < ApplicationController

  def new
    @deck = Deck.last
  end

  def create
  # Amount in cents
  @amount = Deck.last.price * 100

  customer = Stripe::Customer.create(
    email: 'example@stripe.com',
    card: params[:stripeToken]
  )
  charge = Stripe::Charge.create(
    customer: customer.id,
    amount: @amount,
    description: 'Rails Stripe customer',
    currency: 'eur'
  )

rescue Stripe::CardError => e
  flash[:error] = e.message
  redirect_to charges_path
end
end
