class BuyListsController < ApplicationController
  before_action :set_buy_list, only: [:show, :edit, :update, :destroy, :update_all_prices]
  before_action :authenticate_user!

  # GET /buy_lists
  # GET /buy_lists.json
  def index
    @active_buy_lists = BuyList.where(requested: false)
    @inactive_buy_lists = BuyList.where(requested: true)
  end

  # GET /buy_lists/1
  # GET /buy_lists/1.json
  def show
    users = User
      .joins(cards: :buy_list)
      .where('buy_lists.id = ?', @buy_list.id)
      .uniq

    @cards_by_user = []
    users.each do |user|
      @cards_by_user << user.cards.where(buy_list_id: @buy_list.id)
    end

    @total_price = @buy_list.cards.sum('price * quantity')
  end

  # GET /buy_lists/new
  def new
    @buy_list = BuyList.new
  end

  # GET /buy_lists/1/edit
  def edit
  end

  # POST /buy_lists
  # POST /buy_lists.json
  def create
    @buy_list = BuyList.new(buy_list_params)
    @buy_list.user_id = current_user.id
    @buy_list.requested = false

    respond_to do |format|
      if @buy_list.save
        format.html { redirect_to @buy_list, notice: 'Buy list was successfully created.' }
        format.json { render :show, status: :created, location: @buy_list }
      else
        format.html { render :new }
        format.json { render json: @buy_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /buy_lists/1
  # PATCH/PUT /buy_lists/1.json
  def update
    respond_to do |format|
      if @buy_list.update(buy_list_params)
        format.html { redirect_to @buy_list, notice: 'Buy list was successfully updated.' }
        format.json { render :show, status: :ok, location: @buy_list }
      else
        format.html { render :edit }
        format.json { render json: @buy_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /buy_lists/1
  # DELETE /buy_lists/1.json
  def destroy
    @buy_list.destroy
    respond_to do |format|
      format.html { redirect_to buy_lists_url, notice: 'Buy list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update_all_prices
    cards = @buy_list.cards

    require 'nokogiri'
    require 'open-uri'

    cards.each do |card|
      doc = Nokogiri::HTML(open(card.link))

      if !doc.at_css('table.prod-variants .even td').blank?
        card.condition = doc.at_css('table.prod-variants .even td').text
        card.price = doc.at_css('table.prod-variants .even td .price').text[/[0-9\.]+/]
        card.stock = doc.at_css('table.prod-variants .even td .qty').text[/[0-9\.]+/]
      else
        card.stock = nil
        card.price = 0
        card.condition = nil
      end

      card.save
    end

    redirect_to @buy_list, notice: 'Precios actualizados con éxito'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_buy_list
      @buy_list = BuyList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def buy_list_params
      params.require(:buy_list).permit(:user_id, :requested, :order_date, :dolar)
    end
end
