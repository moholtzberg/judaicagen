class PaymentsController < ApplicationController
  before_action :authenticate_user!, :only => [:create]

  def create
    @payment = Payment.new payment_params.merge(email: current_user.email)
    @payment.process_payment
    UserMailer.bought_email(current_user).deliver_later
    @payment.save
    redirect_to home_path, notice: "Payment was succeed!"
  end

  private
    def payment_params
      params.permit :item_id, :card_token
    end

end
