class CardsController < ApplicationController
  before_action :set_card, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /cards
  # GET /cards.json
  def index
    buy_list = BuyList.find params[:buy_list_id]
    @cards = buy_list.cards
  end

  # GET /cards/1
  # GET /cards/1.json
  def show
  end

  # GET /cards/new
  def new
    buy_list = BuyList.find params[:buy_list_id]
    @card = buy_list.cards.build

    @cards = Card.all
  end

  # GET /cards/1/edit
  def edit
  end

  # POST /cards
  # POST /cards.json
  def create
    require 'nokogiri'
    require 'open-uri'

    buy_list = BuyList.find params[:buy_list_id]

    cards = card_params[:link].split("\n")

    cards.each do |link|
      @card = buy_list.cards.build(link: link)

      doc = Nokogiri::HTML(open(link))

      @card.name = doc.at_css('h1.pagetitle').text
      @card.user = current_user
      @card.quantity = 0
      @card.price = 0

      cards_without_stock = []

      if doc.at_css('h2.product-heading').text != 'Currently Out Of Stock'
        @card.condition = doc.at_css('table.prod-variants .even td').text
        @card.price = doc.at_css('table.prod-variants .even td .price').text[/[0-9\.]+/]
        @card.stock = doc.at_css('table.prod-variants .even td .qty').text[/[0-9\.]+/]
        @card.quantity = 1
      else
        cards_without_stock << @card.name
      end

      @card.save
    end

    respond_to do |format|
      format.html { redirect_to new_buy_list_card_url, notice: 'Tus cartas se ha agreado con éxito' }
      format.json { render :show, status: :created, location: @card }
    end
  end

  # PATCH/PUT /cards/1
  # PATCH/PUT /cards/1.json
  def update
    respond_to do |format|
      if @card.update(card_params)
        format.html { redirect_to @card, notice: 'Card was successfully updated.' }
        format.json { render :show, status: :ok, location: @card }
      else
        format.html { render :edit }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cards/1
  # DELETE /cards/1.json
  def destroy
    @card.destroy
    respond_to do |format|
      format.html { redirect_to cards_url, notice: 'Card was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def card_params
      params.require(:card).permit(:name, :price, :link, :user_id)
    end
end
