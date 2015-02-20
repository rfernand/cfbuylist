module Api
  module V1
    class BuyListsController < ApplicationController
      include ActionView::Helpers::NumberHelper

      before_action :set_buy_list, only: [:total_price]

      def total_price
        user_cards = @buy_list.cards.where(user: current_user)

        usd_price = 0
        user_cards.each do |card|
          usd_price += card.price * card.quantity
        end
        clp_price = usd_price * @buy_list.dolar

        render json: {
          usd_price: usd_price,
          clp_price: clp_price,
          usd_price_formatted: number_to_currency(usd_price),
          clp_price_formatted: number_to_currency(clp_price, locale: 'es-CL')
        }
      end

      private

      def set_buy_list
        @buy_list = BuyList.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def buy_list_params
        params.require(:buy_list).permit(:user_id, :requested, :order_date, :dolar)
      end
    end
  end
end
