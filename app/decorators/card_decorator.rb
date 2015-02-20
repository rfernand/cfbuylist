class CardDecorator < Draper::Decorator
  include ActionView::Helpers::NumberHelper
  delegate_all

  def usd_price_formatted
    number_to_currency(price)
  end

  def total_usd_price_formatted
    number_to_currency(price * quantity)
  end

  def clp_price_formatted
    number_to_currency(price * buy_list.dolar, locale: 'es-CL')
  end

  def total_clp_price_formatted
    number_to_currency(total_usd_price * buy_list.dolar, locale: 'es-CL')
  end

  private

  def total_usd_price
    price * quantity
  end
end
