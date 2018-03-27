class PaymentsController < ApplicationController

  def create
    @payment = Payment.new payment_params
    @payment.process_payment
    @payment.save
    redirect_to home_path, notice: "Payment was succeed!"
  end

  private
    def payment_params
      params.permit :item_id, :client_name, :email, :card_token
    end

end
