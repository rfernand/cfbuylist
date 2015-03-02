class BoughtListsController < ApplicationController
  before_action :set_bought_list, only: [:show, :edit, :update, :destroy]

  # GET /bought_lists
  # GET /bought_lists.json
  def index
    @bought_lists = BoughtList.all
  end

  # GET /bought_lists/1
  # GET /bought_lists/1.json
  def show
  end

  # GET /bought_lists/new
  def new
    @bought_list = BoughtList.new
  end

  # GET /bought_lists/1/edit
  def edit
  end

  # POST /bought_lists
  # POST /bought_lists.json
  def create
    @bought_list = BoughtList.new(bought_list_params)

    respond_to do |format|
      if @bought_list.save
        format.html { redirect_to @bought_list, notice: 'Bought list was successfully created.' }
        format.json { render :show, status: :created, location: @bought_list }
      else
        format.html { render :new }
        format.json { render json: @bought_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bought_lists/1
  # PATCH/PUT /bought_lists/1.json
  def update
    respond_to do |format|
      if @bought_list.update(bought_list_params)
        format.html { redirect_to @bought_list, notice: 'Bought list was successfully updated.' }
        format.json { render :show, status: :ok, location: @bought_list }
      else
        format.html { render :edit }
        format.json { render json: @bought_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bought_lists/1
  # DELETE /bought_lists/1.json
  def destroy
    @bought_list.destroy
    respond_to do |format|
      format.html { redirect_to bought_lists_url, notice: 'Bought list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bought_list
      @bought_list = BoughtList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bought_list_params
      params.require(:bought_list).permit(:total_usd, :raw_order, :buy_list_id, :user_id)
    end
end
