module Api
  module V1
    class CardsController < ApplicationController
      protect_from_forgery with: :null_session
      before_action :set_card, only: [:update, :destroy]

      def index
        buy_list = BuyList.find card_params[:buy_list_id]

        cards = buy_list.cards.where(user: current_user).order(:created_at).decorate

        render json: cards, methods: [:usd_price_formatted, :total_usd_price_formatted, :clp_price_formatted, :total_clp_price_formatted]
      end

      def update
        if @card.update(card_params)
          render json: @card
        else
          render json: @card.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @card.destroy

        head :no_content
      end

      private

      def set_card
        @card = Card.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def card_params
        params.require(:card).permit(:name, :price, :link, :user_id, :quantity, :buy_list_id)
      end
    end
  end
end
