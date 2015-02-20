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
    @card = buy_list.cards.build(card_params)

    doc = Nokogiri::HTML(open(card_params[:link]))

    @card.name = doc.at_css('h1.pagetitle').text
    @card.condition = doc.css('table.prod-variants .even td')[0].text
    @card.price = doc.at_css('table.prod-variants .even td .price').text[/[0-9\.]+/]
    @card.stock = doc.at_css('table.prod-variants .even td .qty').text[/[0-9\.]+/]
    @card.user = current_user
    @card.quantity = 1

    respond_to do |format|
      if @card.save
        format.html { redirect_to new_buy_list_card_url, notice: 'Se ha agregado tu carta con éxito' }
        format.json { render :show, status: :created, location: @card }
      else
        format.html { render :new }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end

    rescue
      redirect_to new_buy_list_card_url, alert: 'No existe la carta o no hay stock. Verifica la url.'
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
