class BoughtCardsController < ApplicationController
  before_action :set_bought_card, only: [:show, :edit, :update, :destroy]

  # GET /bought_cards
  # GET /bought_cards.json
  def index
    @bought_cards = BoughtCard.all
  end

  # GET /bought_cards/1
  # GET /bought_cards/1.json
  def show
  end

  # GET /bought_cards/new
  def new
    @bought_card = BoughtCard.new
  end

  # GET /bought_cards/1/edit
  def edit
  end

  # POST /bought_cards
  # POST /bought_cards.json
  def create
    @bought_card = BoughtCard.new(bought_card_params)

    respond_to do |format|
      if @bought_card.save
        format.html { redirect_to @bought_card, notice: 'Bought card was successfully created.' }
        format.json { render :show, status: :created, location: @bought_card }
      else
        format.html { render :new }
        format.json { render json: @bought_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bought_cards/1
  # PATCH/PUT /bought_cards/1.json
  def update
    respond_to do |format|
      if @bought_card.update(bought_card_params)
        format.html { redirect_to @bought_card, notice: 'Bought card was successfully updated.' }
        format.json { render :show, status: :ok, location: @bought_card }
      else
        format.html { render :edit }
        format.json { render json: @bought_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bought_cards/1
  # DELETE /bought_cards/1.json
  def destroy
    @bought_card.destroy
    respond_to do |format|
      format.html { redirect_to bought_cards_url, notice: 'Bought card was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bought_card
      @bought_card = BoughtCard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bought_card_params
      params.require(:bought_card).permit(:card_id, :usd_price, :user_id, :condition, :quantity, :bought_list_id)
    end
end
