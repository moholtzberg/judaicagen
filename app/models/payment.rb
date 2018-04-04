class Payment < ActiveRecord::Base
  belongs_to :item

  def process_payment
  	customer = Stripe::Customer.create email: email
  	customer.sources.create(card: card_token)

  	item = Item.find(item_id)

  	Stripe::Charge.create customer: customer.id,
                          amount: (item.price * 100).to_i,
                          description: item.title,
                          currency: "usd"

    item.update(:sold => 'true')
    UserMailer.sold_email(item).deliver_later
  end
end
